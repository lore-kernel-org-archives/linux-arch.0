From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/3] arm64 cpuinfo: implement sysfs nodes for arm64
Date: Tue, 10 Dec 2019 14:33:07 +0100
Message-ID: <11195456.EmMzWPVPDU@skinner.arch.suse.de>
References: <20191206162421.15050-1-trenn@suse.de> <25032400.G9DUGnJgnc@skinner.arch.suse.de> <20191209173804.GD7489@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191209173804.GD7489@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Felix Schnizlein <fschnizlein@suse.com>, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Felix Schnizlein <fschnizlein@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Monday, December 9, 2019 6:38:05 PM CET Will Deacon wrote:
> On Mon, Dec 09, 2019 at 12:28:44PM +0100, Thomas Renninger wrote:
> > On Monday, December 9, 2019 11:31:11 AM CET Will Deacon wrote:
> > > On Fri, Dec 06, 2019 at 05:24:21PM +0100, Thomas Renninger wrote:
> > > > From: Felix Schnizlein <fschnizlein@suse.de>
> > > > 
> > > > Export all information from /proc/cpuinfo to sysfs:
> > > > implementer, architecture, variant, part, revision,
> > > > bogomips and flags are exported.
> > > > 
> > > > Example:
> > > > /sys/devices/system/cpu/cpu1/info/:[0]# head *
> > 
> > ...
> > 
> > > > ==> flags <==
> > > > fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid asimdrdm
> > 
> > ...
> > 
> > > I don't understand why we need this on arm64

Again: proc is moving to sys.
You probably export feature flags in /proc/cpuinfo for a good reason.
So where in sysfs should this show up?

> Even if we exposed them via sysfs, existing
> software will continue to grep them out of /proc/cpuinfo because it's more
> reliable and new software would still be encouraged to use either the HWCAPs
> directly or, even better, our CPUID (MRS) emulation.

Ok, so /proc/cpuinfo
Features:

is deprecated on arm64. Is that correct?
Then it would indeed not make sense to port it/anything to sys.
 
It is this comment you are referring to:

arch/arm64/kernel/cpuinfo.c
                 * Dump out the common processor features in a single line.
                 * Userspace should read the hwcaps with getauxval(AT_HWCAP)
                 * rather than attempting to parse this, but there's a body of
                 * software which does already (at least for 32-bit).

Then let's shorten this.
Sorry for keep digging/asking.

Felix made this up rather neat, so that other archs can implement to expose 
sysfs CPU info easy and consistent.
While x86 also ported parts of cpuinfo, e.g. microcode version, most general
info is still missing in sysfs.

If I find the time, I may check for other archs like ppc64le or s390x to find
data which still should show up in sysfs and could then be put in the same
directory/file structure.

ARM people may still want to make use of this at some point of time, if 
appropriate. I'll drop patch 3/3.

Thanks for explaining me the ARM details,

   Thomas
