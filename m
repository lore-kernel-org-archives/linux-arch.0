From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 07/14] [POWERPC] Populate cpu_enabled_map
Date: Tue, 15 Jul 2008 19:04:18 -0600
Message-ID: <20080716010418.GH10919@ldl.fc.hp.com>
References: <20080715023344.2528.1836.stgit@blender.achiang> <20080715023420.2528.44404.stgit@blender.achiang> <1216101095.7740.74.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:41760 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362AbYGPBET (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2008 21:04:19 -0400
Content-Disposition: inline
In-Reply-To: <1216101095.7740.74.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, Paul Mackerras <paulus@samba.org>

* Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> On Mon, 2008-07-14 at 20:34 -0600, Alex Chiang wrote:
> > Populate the cpu_enabled_map correctly.
> > 
> > Note that this patch does not actually make any decisions based
> > on the contents of the map.
> > 
> > However, as the map is presented via sysfs in:
> > 
> > 	/sys/devices/system/cpu/
> > 
> > It should be populated correctly.
> 
> Care to educate me on the difference between online_map and
> enabled_map ?

enabled_map is closer conceptually to present_map than
online_map.

present_map are CPUs that are actually plugged in

online_map are CPUs that have had cpu_up() called on them; ie.
schedulable

enabled_map is somewhere inbetween -- the CPUs are plugged in,
but we don't want to cpu_up() them. On hp ia64 systems, these
CPUs are disabled by system firmware.

Currently, a user can only configure/deconfigure the CPUs from
the system firmware interface. By providing a sysfs interface for
these CPUs, we can allow the user to configure/deconfigure them
from userspace. More realistically, higher level managability
software now has an OS-level interface to interact with these
CPUs.

Might this be useful for ppc and your hypervisor based
architecture? I could imagine your hypervisor telling the kernel
about all the physically present CPUs, but then you would be able
to have finer grained control using the enabled_map.

I haven't studied your code in depth, so maybe you can just do
everything with pure online/offline, but at least on my
platforms, there are use-cases where we might want something
in-between.

Thanks.

/ac
