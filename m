From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Fri, 29 Nov 2013 08:44:41 -0800
Message-ID: <CA+55aFwHgnH4h0YwybThQjvicFCVbGbwaAy3Fw0b738gJMtqBA@mail.gmail.com>
References: <CA+55aFyjisiM1eC53STpcKLky84n8JRz3Aagp-CQd_+3AOJhow@mail.gmail.com>
	<20131126225136.GG4137@linux.vnet.ibm.com>
	<20131127101613.GC9032@mudshark.cambridge.arm.com>
	<20131127171143.GN4137@linux.vnet.ibm.com>
	<20131128114058.GC21354@mudshark.cambridge.arm.com>
	<20131128173853.GV4137@linux.vnet.ibm.com>
	<20131128180318.GE16203@mudshark.cambridge.arm.com>
	<20131128182712.GW4137@linux.vnet.ibm.com>
	<20131128185341.GG16203@mudshark.cambridge.arm.com>
	<20131128195039.GX4137@linux.vnet.ibm.com>
	<20131129161711.GG31000@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=001a11c3b1b0ff437704ec538b9e
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20131129161711.GG31000@mudshark.cambridge.arm.com>
Sender: owner-linux-mm@kvack.org
To: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Figo. zhang" <figo1802@gmail.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Rik van Riel <riel@redhat.com>, Waiman Long <waiman.long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Michel Lespinasse <walken@google.com>, Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Hurley <peter@hurleysoftware.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Alex Shi <alex.shi@linaro.org>, Andrea Arcangeli <aarcange@redhat.com>, Scott J Norton <scott.norton@hp.com>, Thomas Gleixner <tglx@linutronix.de>, D
List-Id: linux-arch.vger.kernel.org

--001a11c3b1b0ff437704ec538b9e
Content-Type: text/plain; charset=UTF-8

On Nov 29, 2013 8:18 AM, "Will Deacon" <will.deacon@arm.com> wrote:
>
>  To get some sort of
> idea, I tried adding a dmb to the start of spin_unlock on ARMv7 and I saw
a
> 3% performance hit in hackbench on my dual-cluster board.

Don't do a dmb. Just do a dummy release. You just said that on arm64 a
unlock+lock is a memory barrier, so just make the mb__before_spinlock() be
a dummy store with release to the stack..

That should be noticeably cheaper than a full dmb.

       Linus

--001a11c3b1b0ff437704ec538b9e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Nov 29, 2013 8:18 AM, &quot;Will Deacon&quot; &lt;<a href=3D"mailto:will=
.deacon@arm.com">will.deacon@arm.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 To get some sort of<br>
&gt; idea, I tried adding a dmb to the start of spin_unlock on ARMv7 and I =
saw a<br>
&gt; 3% performance hit in hackbench on my dual-cluster board.</p>
<p dir=3D"ltr">Don&#39;t do a dmb. Just do a dummy release. You just said t=
hat on arm64 a unlock+lock is a memory barrier, so just make the mb__before=
_spinlock() be a dummy store with release to the stack..</p>
<p dir=3D"ltr">That should be noticeably cheaper than a full dmb. </p>
<p dir=3D"ltr">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linus</p>

--001a11c3b1b0ff437704ec538b9e--

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
