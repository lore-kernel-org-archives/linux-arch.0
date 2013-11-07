From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 3/5] MCS Lock: Barrier corrections
Date: Thu, 7 Nov 2013 21:06:29 +0900
Message-ID: <CA+55aFwn1HUt3iXo6Zz8j1HUJi+qJ1NfcnUz-P+XCYLL7gjCMQ@mail.gmail.com>
References: <cover.1383771175.git.tim.c.chen@linux.intel.com>
	<1383773827.11046.355.camel@schen9-DESK>
	<CA+55aFyNX=5i0hmk-KuD+Vk+yBD-kkAiywx1Lx_JJmHVPx=1wA@mail.gmail.com>
	<CANN689HkNP-UZOu+vDCFPG5_k=BNZG6a+oP+Ope16vLc2ShFzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=089e0115f6828bdaee04ea95184d
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CANN689HkNP-UZOu+vDCFPG5_k=BNZG6a+oP+Ope16vLc2ShFzw@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Michel Lespinasse <walken@google.com>
Cc: Waiman Long <waiman.long@hp.com>, Arnd Bergmann <arnd@arndb.de>, Rik van Riel <riel@redhat.com>, Aswin Chandramouleeswaran <aswin@hp.com>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "Figo. zhang" <figo1802@gmail.com>, linux-arch@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Peter Hurley <peter@hurleysoftware.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, linux-kernel@vger.kernel.org, Scott J Norton <scott.norton@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, Matthew R Wilcox <matthew.r.w>
List-Id: linux-arch.vger.kernel.org

--089e0115f6828bdaee04ea95184d
Content-Type: text/plain; charset=UTF-8

On Nov 7, 2013 6:55 PM, "Michel Lespinasse" <walken@google.com> wrote:
>
> Rather than writing arch-specific locking code, would you agree to
> introduce acquire and release memory operations ?

Yes, that's probably the right thing to do. What ops do we need? Store with
release, cmpxchg and load with acquire? Anything else?

      Linus

--089e0115f6828bdaee04ea95184d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Nov 7, 2013 6:55 PM, &quot;Michel Lespinasse&quot; &lt;<a href=3D"mailto=
:walken@google.com">walken@google.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Rather than writing arch-specific locking code, would you agree to<br>
&gt; introduce acquire and release memory operations ?</p>
<p dir=3D"ltr">Yes, that&#39;s probably the right thing to do. What ops do =
we need? Store with release, cmpxchg and load with acquire? Anything else?<=
/p>
<p dir=3D"ltr">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linus</p>

--089e0115f6828bdaee04ea95184d--

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
