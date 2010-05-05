From: Takuya Yoshikawa <takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC][PATCH resend 8/12] asm-generic: bitops: introduce le bit
 offset macro
Date: Wed, 5 May 2010 11:59:24 +0900
Message-ID: <20100505115924.7bb92036.takuya.yoshikawa@gmail.com>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<20100504220500.7695cd66.takuya.yoshikawa@gmail.com>
	<201005041703.00549.arnd@arndb.de>
	<4BE04677.4060608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-ppc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BE04677.4060608-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: kvm-ppc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Avi Kivity <avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, yoshikawa.takuya-gVGce1chcLdL9jVzuh4AOg@public.gmane.org, fernando-gVGce1chcLdL9jVzuh4AOg@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Tue, 04 May 2010 19:08:23 +0300
Avi Kivity <avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On 05/04/2010 06:03 PM, Arnd Bergmann wrote:
> > On Tuesday 04 May 2010, Takuya Yoshikawa wrote:
...
> >> So let us use the le bit offset calculation part by defining it as a new
> >> macro: generic_le_bit_offset() .
> >>      
> > Does this work correctly if your user space is 32 bits (i.e. unsigned long
> > is different size in user space and kernel) in both big- and little-endian
> > systems?
> >
> > I'm not sure about all the details, but I think you cannot in general share
> > bitmaps between user space and kernel because of this.
> >    
> 
> That's why the bitmaps are defined as little endian u64 aligned, even on 
> big endian 32-bit systems.  Little endian bitmaps are wordsize agnostic, 
> and u64 alignment ensures we can use long-sized bitops on mixed size 
> systems.

There was a suggestion to propose set_le_bit_user() kind of macros.
But what I thought was these have a constraint you two explained and seemed to be
a little bit specific to some area, like KVM.

So I decided to propose just the offset calculation macro.

  Thanks, Takuya
