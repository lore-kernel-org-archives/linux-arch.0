From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v3 3/5] MCS Lock: Barrier corrections
Date: Wed, 06 Nov 2013 23:29:54 -0500
Message-ID: <527B1742.60400@hp.com>
References: <cover.1383771175.git.tim.c.chen@linux.intel.com> <1383773827.11046.355.camel@schen9-DESK> <CA+55aFyNX=5i0hmk-KuD+Vk+yBD-kkAiywx1Lx_JJmHVPx=1wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------010800000509090703040100"
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CA+55aFyNX=5i0hmk-KuD+Vk+yBD-kkAiywx1Lx_JJmHVPx=1wA@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, "Figo. zhang" <figo1802@gmail.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, linux-arch@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, George Spelvin <linux@horizon.com>, Michel Lespinasse <walken@google.com>, Ingo Molnar <mingo@elte.hu>, Peter Hurley <peter@hurleysoftware.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Alex Shi <alex.shi@linaro.org>, Andrea Arcangeli <aarcange@redhat.com>, Scott J Norton <scott.norton@hp.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>
List-Id: linux-arch.vger.kernel.org

This is a multi-part message in MIME format.
--------------010800000509090703040100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/06/2013 08:39 PM, Linus Torvalds wrote:
>
> Sorry about the HTML crap, the internet connection is too slow for my 
> normal email habits, so I'm using my phone.
>
> I think the barriers are still totally wrong for the locking functions.
>
> Adding an smp_rmb after waiting for the lock is pure BS. Writes in the 
> locked region could percolate out of the locked region.
>
> The thing is, you cannot do the memory ordering for locks in any same 
> generic way. Not using our current barrier system. On x86 (and many 
> others) the smp_rmb will work fine, because writes are never moved 
> earlier. But on other architectures you really need an acquire to get 
> a lock efficiently. No separate barriers. An acquire needs to be on 
> the instruction that does the lock.
>
> Same goes for unlock. On x86 any store is a fine unlock, but on other 
> architectures you need a store with a release marker.
>
> So no amount of barriers will ever do this correctly. Sure, you can 
> add full memory barriers and it will be "correct" but it will be 
> unbearably slow, and add totally unnecessary serialization. So 
> *correct* locking will require architecture support.
>
>

Yes, we realized that we can't do it in a generic way without 
introducing unwanted overhead. So I had sent out another patch to do it 
in an architecture specific way to enable each architecture to choose 
their memory barrier. It was at the end of the v3 and v4 patch series.

-Longman

--------------010800000509090703040100
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    On 11/06/2013 08:39 PM, Linus Torvalds wrote:
    <blockquote
cite=3D"mid:CA+55aFyNX=3D5i0hmk-KuD+Vk+yBD-kkAiywx1Lx_JJmHVPx=3D1wA@mail.=
gmail.com"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DU=
TF-8">
      <p dir=3D"ltr">Sorry about the HTML crap, the internet connection i=
s
        too slow for my normal email habits, so I'm using my phone. </p>
      <p dir=3D"ltr">I think the barriers are still totally wrong for the
        locking functions.</p>
      <p dir=3D"ltr">Adding an smp_rmb after waiting for the lock is pure
        BS. Writes in the locked region could percolate out of the
        locked region.</p>
      <p dir=3D"ltr">The thing is, you cannot do the memory ordering for
        locks in any same generic way. Not using our current barrier
        system. On x86 (and many others) the smp_rmb will work fine,
        because writes are never moved earlier. But on other
        architectures you really need an acquire to get a lock
        efficiently. No separate barriers. An acquire needs to be on the
        instruction that does the lock.</p>
      <p dir=3D"ltr">Same goes for unlock. On x86 any store is a fine
        unlock, but on other architectures you need a store with a
        release marker.</p>
      <p dir=3D"ltr">So no amount of barriers will ever do this correctly=
.
        Sure, you can add full memory barriers and it will be "correct"
        but it will be unbearably slow, and add totally unnecessary
        serialization. So *correct* locking will require architecture
        support.</p>
      <p dir=3D"ltr">=C2=A0=C2=A0=C2=A0=C2=A0 <br>
      </p>
    </blockquote>
    <br>
    Yes, we realized that we can't do it in a generic way without
    introducing unwanted overhead. So I had sent out another patch to do
    it in an architecture specific way to enable each architecture to
    choose their memory barrier. It was at the end of the v3 and v4
    patch series.<br>
    <br>
    -Longman<br>
  </body>
</html>

--------------010800000509090703040100--

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
