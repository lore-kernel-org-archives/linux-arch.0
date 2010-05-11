From: Marcelo Tosatti <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC][PATCH 11/12] KVM: introduce new API for getting/switching
 dirty bitmaps
Date: Tue, 11 May 2010 00:43:29 -0300
Message-ID: <20100511034329.GB3458@amt.cnet>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
 <20100504220821.d68bde57.takuya.yoshikawa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-ppc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100504220821.d68bde57.takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: kvm-ppc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takuya Yoshikawa <takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, yoshikawa.takuya-gVGce1chcLdL9jVzuh4AOg@public.gmane.org, fernando-gVGce1chcLdL9jVzuh4AOg@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Tue, May 04, 2010 at 10:08:21PM +0900, Takuya Yoshikawa wrote:
> Now that dirty bitmaps are accessible from user space, we export the
> addresses of these to achieve zero-copy dirty log check:
> 
>   KVM_GET_USER_DIRTY_LOG_ADDR
> 
> We also need an API for triggering dirty bitmap switch to take the full
> advantage of double buffered bitmaps.
> 
>   KVM_SWITCH_DIRTY_LOG
> 
> See the documentation in this patch for precise explanations.
> 
> About performance improvement: the most important feature of switch API
> is the lightness. In our test, this appeared in the form of improved
> responses for GUI manipulations.
> 
> Signed-off-by: Takuya Yoshikawa <yoshikawa.takuya-gVGce1chcLdL9jVzuh4AOg@public.gmane.org>
> Signed-off-by: Fernando Luis Vazquez Cao <fernando-gVGce1chcLdL9jVzuh4AOg@public.gmane.org>
> CC: Avi Kivity <avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> CC: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
> ---
>  Documentation/kvm/api.txt |   87 +++++++++++++++++++++++++++++++++++++++++++++
>  arch/ia64/kvm/kvm-ia64.c  |   27 +++++++++-----
>  arch/powerpc/kvm/book3s.c |   18 +++++++--
>  arch/x86/kvm/x86.c        |   44 ++++++++++++++++-------
>  include/linux/kvm.h       |   11 ++++++
>  include/linux/kvm_host.h  |    4 ++-
>  virt/kvm/kvm_main.c       |   63 +++++++++++++++++++++++++++++----
>  7 files changed, 220 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/kvm/api.txt b/Documentation/kvm/api.txt
> index a237518..c106c83 100644
> --- a/Documentation/kvm/api.txt
> +++ b/Documentation/kvm/api.txt
> @@ -892,6 +892,93 @@ arguments.
>  This ioctl is only useful after KVM_CREATE_IRQCHIP.  Without an in-kernel
>  irqchip, the multiprocessing state must be maintained by userspace.
>  
> +4.39 KVM_GET_USER_DIRTY_LOG_ADDR
> +
> +Capability: KVM_CAP_USER_DIRTY_LOG (>=1 see below)
> +Architectures: all
> +Type: vm ioctl
> +Parameters: struct kvm_user_dirty_log (in/out)
> +Returns: 0 on success, -1 on error
> +
> +This ioctl makes it possible to use KVM_SWITCH_DIRTY_LOG (see 4.40) instead
> +of the old dirty log manipulation by KVM_GET_DIRTY_LOG.
> +
> +A bit about KVM_CAP_USER_DIRTY_LOG
> +
> +Before this ioctl was introduced, dirty bitmaps for dirty page logging were
> +allocated in the kernel's memory space.  But we have now moved them to user
> +space to get more flexiblity and performance.  To achive this move without
> +breaking the compatibility, we will split KVM_CAP_USER_DIRTY_LOG capability
> +into a few generations which can be identified by its check extension
> +return values.
> +
> +This KVM_GET_USER_DIRTY_LOG_ADDR belongs to the first generation with the
> +KVM_SWITCH_DIRTY_LOG (4.40) and must be supported by all generations.
> +
> +What you get
> +
> +By using this, you can get paired bitmap addresses which are accessible from
> +user space.  See the explanation in 4.40 for the roles of these two bitmaps.
> +
> +How to Get
> +
> +Before calling this, you have to set the slot member of kvm_user_dirty_log
> +to indicate the target memory slot.
> +
> +struct kvm_user_dirty_log {
> +	__u32 slot;
> +	__u32 flags;
> +	__u64 dirty_bitmap;
> +	__u64 dirty_bitmap_old;
> +};
> +
> +The addresses will be set in the paired members: dirty_bitmap and _old.

Why not pass the bitmap address to the kernel, instead of having the
kernel allocate it. Because apparently you plan to do that in a new
generation anyway?

Also, why does the kernel need to know about different bitmaps?

One alternative would be:

KVM_SWITCH_DIRTY_LOG passing the address of a bitmap. If the active
bitmap was clean, it returns 0, no switch performed. If the active
bitmap was dirty, the kernel switches to the new bitmap and returns 1.

And the responsability of cleaning the new bitmap could also be left
for userspace.
