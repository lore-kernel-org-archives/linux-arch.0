From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 9/9] qspinlock, x86,
	kvm: Implement KVM support for paravirt qspinlock
Date: Wed, 18 Mar 2015 22:45:55 -0400
Message-ID: <550A3863.2060808@hp.com>
References: <20150316131613.720617163@infradead.org>
	<20150316133112.333845162@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2596025477776393937=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150316133112.333845162@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org, kvm@vger.kernel.org, konrad.wilk@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, oleg@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, david.vrabel@citrix.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, doug.hatch@hp.com
List-Id: linux-arch.vger.kernel.org

This is a multi-part message in MIME format.
--===============2596025477776393937==
Content-Type: multipart/alternative;
 boundary="------------010900080506010607050409"

This is a multi-part message in MIME format.
--------------010900080506010607050409
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/16/2015 09:16 AM, Peter Zijlstra wrote:
> Implement the paravirt qspinlock for x86-kvm.
>
> We use the regular paravirt call patching to switch between:
>
>    native_queue_spin_lock_slowpath()	__pv_queue_spin_lock_slowpath()
>    native_queue_spin_unlock()		__pv_queue_spin_unlock()
>
> We use a callee saved call for the unlock function which reduces the
> i-cache footprint and allows 'inlining' of SPIN_UNLOCK functions
> again.
>
> We further optimize the unlock path by patching the direct call with a
> "movb $0,%arg1" if we are indeed using the native unlock code. This
> makes the unlock code almost as fast as the !PARAVIRT case.
>
> This significantly lowers the overhead of having
> CONFIG_PARAVIRT_SPINLOCKS enabled, even for native code.
>
>
> Signed-off-by: Peter Zijlstra (Intel)<peterz@infradead.org>

I do have some concern about this call site patching mechanism as the 
modification is not atomic. The spin_unlock() calls are in many places 
in the kernel. There is a possibility that a thread is calling a certain 
spin_unlock call site while it is being patched by another one with the 
alternative() function call.

So far, I don't see any problem with bare metal where 
paravirt_patch_insns() is used to patch it to the move instruction. 
However, in a virtual guest enivornment where paravirt_patch_call() was 
used, there were situations where the system panic because of page fault 
on some invalid memory in the kthread. If you look at the 
paravirt_patch_call(), you will see:

     :
b->opcode = 0xe8; /* call */
b->delta = delta;

If another CPU reads the instruction at the call site at the right 
moment, it will get the modified call instruction, but not the new delta 
value. It will then jump to a random location. I believe that was 
causing the system panic that I saw.

So I think it is kind of risky to use it here unless we can guarantee 
that call site patching is atomic wrt other CPUs.

-Longman


--------------010900080506010607050409
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    On 03/16/2015 09:16 AM, Peter Zijlstra wrote:
    <blockquote cite=3D"mid:20150316133112.333845162@infradead.org"
      type=3D"cite">
      <div class=3D"moz-text-plain" wrap=3D"true" graphical-quote=3D"true=
"
        style=3D"font-family: -moz-fixed; font-size: 12px;"
        lang=3D"x-unicode">
        <pre wrap=3D"">Implement the paravirt qspinlock for x86-kvm.

We use the regular paravirt call patching to switch between:

  native_queue_spin_lock_slowpath()	__pv_queue_spin_lock_slowpath()
  native_queue_spin_unlock()		__pv_queue_spin_unlock()

We use a callee saved call for the unlock function which reduces the
i-cache footprint and allows 'inlining' of SPIN_UNLOCK functions
again.

We further optimize the unlock path by patching the direct call with a
"movb $0,%arg1" if we are indeed using the native unlock code. This
makes the unlock code almost as fast as the !PARAVIRT case.

This significantly lowers the overhead of having
CONFIG_PARAVIRT_SPINLOCKS enabled, even for native code.


Signed-off-by: Peter Zijlstra (Intel) <a moz-do-not-send=3D"true" class=3D=
"moz-txt-link-rfc2396E" href=3D"mailto:peterz@infradead.org">&lt;peterz@i=
nfradead.org&gt;</a></pre>
      </div>
    </blockquote>
    <br>
    I do have some concern about this call site patching mechanism as
    the modification is not atomic. The spin_unlock() calls are in many
    places in the kernel. There is a possibility that a thread is
    calling a certain spin_unlock call site while it is being patched by
    another one with the alternative() function call. <br>
    <br>
    So far, I don't see any problem with bare metal where
    paravirt_patch_insns() is used to patch it to the move instruction.
    However, in a virtual guest enivornment where paravirt_patch_call()
    was used, there were situations where the system panic because of
    page fault on some invalid memory in the kthread. If you look at the
    paravirt_patch_call(), you will see:<br>
    <br>
    =C2=A0=C2=A0=C2=A0 :<br>
    b-&gt;opcode =3D 0xe8; /* call */<br>
    b-&gt;delta =3D delta;<br>
    <br>
    If another CPU reads the instruction at the call site at the right
    moment, it will get the modified call instruction, but not the new
    delta value. It will then jump to a random location. I believe that
    was causing the system panic that I saw.<br>
    <br>
    So I think it is kind of risky to use it here unless we can
    guarantee that call site patching is atomic wrt other CPUs.<br>
    <br>
    -Longman<br>
    <br>
  </body>
</html>

--------------010900080506010607050409--

--===============2596025477776393937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2596025477776393937==--
