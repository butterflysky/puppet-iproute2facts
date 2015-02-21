# iproute2.rb
#
# Note: only parses the output of /sbin/ip addr right now; ip route and all the other subcommands of /sbin/ip are not yet implemented.
#
#
ipaddr = Facter::Util::Resolution.exec(%q</sbin/ip addr show>).
        split("\n").
        find_all{ |item| item =~ /^\d/ }.
        join('__').
        split(/(:|__)\s*/).
        find_all{ |item| item =~ /^[a-zA-Z]/ }

deviceinfo = Hash.new
seencount = Hash.new

ipaddr.each do |item|
    deviceinfo[item] = Facter::Util::Resolution.exec(%q</sbin/ip addr show > + item).
        gsub(/^\d*:\s*#{item}:\s*/,'state ').
        gsub(/ mtu/,"\nmtu").
        gsub(/ qdisc/,"\nqdisc").
        gsub(/ qlen/,"\nqlen").
        gsub(/ preferred_lft/, "\npreferred_lft").
        gsub(/link\/(\w+)\s+(\S+)\s+(brd\s+(\S+))?/, "linktype \\1\nlinkaddress \\2\nlinkbroadcast \\4\n").
        gsub(/inet\s+(\S+)\s+(brd\s+(\S+)\s+)?scope\s+(.*?)\n/,"inetaddress \\1\ninetbroadcast \\3\ninetscope \\4\n").
        gsub(/inet6\s+(\S+)\s+(brd\s+(\S+)\s+)?scope\s+(.*?)\n/,"inet6address \\1\ninet6broadcast \\3\ninet6scope \\4\n").
        gsub(/\n\s*/,"\n").
        gsub(/ +/, " ").
        split("\n")
end

deviceinfo.keys.each do |key|
    deviceinfo[key].each do |line|
        firstspace = line.index(" ")
        factname = "iproute2_addr_#{key}_#{line[0..firstspace - 1]}"

        if seencount.has_key?(factname)
             seencount[factname] += 1
             factname_real = factname + "_#{seencount[factname]}"
        else
            seencount[factname] = 1
            factname_real = factname
        end

        Facter.add(factname_real) do
            setcode do
                line[firstspace..-1].gsub(/\s+/,' ').gsub(/^\s+/,'').gsub(/\s+$/,'')
            end
        end
    end
end
