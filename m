From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Turn CONFIG_STRICT_DEVMEM in sysctl
	dev.mem.restricted
Date: Sun, 16 Nov 2008 15:45:41 +0000
Message-ID: <20081116154541.1f196f1e@lxorguk.ukuu.org.uk>
References: <1226846868-9595-1-git-send-email-bwalle@suse.de>
	<20081116150756.3cece2de@lxorguk.ukuu.org.uk>
	<20081116162003.04267538@kopernikus.site>
Reply-To: "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <crash-utility-bounces@redhat.com>
In-Reply-To: <20081116162003.04267538@kopernikus.site>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/crash-utility>,
	<mailto:crash-utility-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/crash-utility>
List-Post: <mailto:crash-utility@redhat.com>
List-Help: <mailto:crash-utility-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/crash-utility>,
	<mailto:crash-utility-request@redhat.com?subject=subscribe>
Sender: crash-utility-bounces@redhat.com
Errors-To: crash-utility-bounces@redhat.com
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, crash-utility@redhat.com
List-Id: linux-arch.vger.kernel.org

> I don't need to explain what protection STRICT_DEVMEM provides, just
> because I didn't submit STRICT_DEVMEM. However:

Which also doesn't explain what this turd is for.
 
>     Author: Arjan van de Ven <arjan@linux.intel.com>
>     Date:   Thu Apr 24 23:40:47 2008 +0200
> 
>     The X server needs access to /dev/mem for the PCI space, but it doesn't need
>     access to memory; both the file permissions and SELinux permissions of /dev/mem
>     just make X effectively super-super powerful. With the exception of the
>     BIOS area, there's just no valid app that uses /dev/mem on actual memory.

Note that this statement directly conflicts with your debugging statement
you need it switchable, and directly conflicts with the Red Hat crash
memory access. So you are trying to support something with a changelog
that demonstrates that what you are trying to make configurable is
completely broken anyway

The functionality provided by STRICT_DEVMEM is the same with it on or off
- absolutely *nothing*.

> So without that patch, a distributor needs to have two kernels: One
> with SELinux and with /dev/mem protection and one without it. If I
> remember correctly, you can turn off SELinux on the boot command line.

You can turn it off at boot time, but if you intend not to use it then it
is better (and measurably so with microbenchmark tools) to compile
without it. Red Hat doesn't do the two kernels as the maintenance cost
exceeds the gain for customers. Note however that compiling it out really
does compile it *out* and the overhead is gone totally for the many
embedded and other devices that don't use it.

> But I never used it. At least I don't see -selinux and -noselinux
> kernels in Redhat.

It is Red Hat, two words and a trademark (sorry but our legal people
insist we remind people who get it wrong).

Also I don't actually care what Red Hat ship. The fact Red Hat (or any
vendor) ship something doesn't make it a good idea.

> However, with my patch you can make everything configurable. With
> SELinux or Apparmor you can also protect the user from writing that
> sysctl. Or from loading kernel modules that circumvent that protection.

With your patch I get crap in the kernel I don't need. In every kernel
including those on memory tight devices like wireless routers that don't
need it.

You are turd polishing, and what is needed is a shovel.

Even if you want to turd polish there are cleaner solutions. A process
with CAP_SYS_RAWIO can cheerfully bypass any restriction you try and
place so you could rip out all the sysctl crap and just say that
the /dev/mem restriction doesn't apply to a CAP_SYS_RAWIO process. It's
still a turd but the change is a lot cleaner and one line long with no
userspace semantics, paths and the like.

There are proper ways to deal with X, modern video cards and modern
security models. They involve using framebuffer mappings off the PCI
device node itself and DRI.

Alan
