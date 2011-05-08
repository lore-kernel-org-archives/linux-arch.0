Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:55150 "EHLO mail.avalus.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559Ab1EHMbH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 8 May 2011 08:31:07 -0400
Date: Sun, 08 May 2011 13:31:01 +0100
From: Alex Bligh <alex@alex.org.uk>
Reply-To: Alex Bligh <alex@alex.org.uk>
Subject: Re: [PATCH 0/7] Network namespace manipulation with file
 descriptors
Message-ID: <974CF8842C14240ADB10AD9C@nimrod.local>
In-Reply-To: <m1fwoqoapn.fsf@fess.ebiederm.org>
References: <m1tyd7p7tq.fsf@fess.ebiederm.org>
 	<3A54AB469A0294933EAC2257@nimrod.local> <m1fwoqoapn.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Linux Containers <containers@lists.osdl.org>, linux-fsdevel@vger.kernel.org, Alex Bligh <alex@alex.org.uk>
Message-ID: <20110508123101.J81Z0zr6OqiIpvlJAJKUHYbPE4CsyEvYA9goPxYKR0Y@z>

Eric,

--On 7 May 2011 07:18:44 -0700 "Eric W. Biederman" <ebiederm@xmission.com> 
wrote:

> You are essentially describing my setns system call.

Great - thanks.

>> As a secondary issue, ever without your patch, it would be really
>> useful to be able to read from userspace the current network namespace.
>> (i.e. the pid concerned, or 1 if not unshared). I would like to
>> simply modify a routing daemon's init script so it doesn't start
>> if in the host, e.g. at the top:
>>  [ `cat /proc/.../networknamespace` eq 1 ] && exit 0
>
> You can read the processes network namespace by opening
> /proc/<pid>/ns/net.  Unfortunately comparing the network
> namespaces for identity is another matter.  You will probably
> be better off simply forcing the routing daemon to start
> in the desired network namespace in it's initscript.

It's solely a minor convenience issue. The network namespace is
unshared by the filing system namespace isn't. So there's an
/etc/init.d/bird, which I would like to remain there so I
can call it from the network namespace concerned (which
doesn't exist at boot time). But I'd also like it not to run
at boot time. So it would be useful to me if the script could
check whether it is running in the default namespace and
refuse to launch if so.

I note the /proc/ file you mention is not present in the main tree at
the moment.

> For purposes of clarity please have a look at my work in
> progress patch for iproute2.  This demonstrates how I expect
> userspace to work in a multi-network namespace world.

Will do

-- 
Alex Bligh
