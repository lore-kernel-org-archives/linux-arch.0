Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:52112 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726031AbfE3TQj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 15:16:39 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Date: Thu, 30 May 2019 19:16:36 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2520D9C@us01wembx1.internal.synopsys.com>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190530185358.GG28207@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190530191636.cLveYZzYg484w8Gr3eLycJTJxjnT_xtBMYum-ZrW1tg@z>

On 5/30/19 11:55 AM, Paul E. McKenney wrote:=0A=
>=0A=
>> I'm not sure how to interpret "natural alignment" for the case of double=
=0A=
>> load/stores on 32-bit systems where the hardware and ABI allow for 4 byt=
e=0A=
>> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)=0A=
>>=0A=
>> I presume (and the question) that lkmm doesn't expect such 8 byte load/s=
tores to=0A=
>> be atomic unless 8-byte aligned=0A=
> I would not expect 8-byte accesses to be atomic on 32-bit systems unless=
=0A=
> some special instruction was in use.  But that usually means special=0A=
> intrinsics or assembly code.=0A=
=0A=
Thx for confirming.=0A=
=0A=
In cases where we *do* expect the atomicity, it seems there's some existing=
 type=0A=
checking but isn't water tight.=0A=
e.g.=0A=
=0A=
#define __smp_load_acquire(p)                        \=0A=
({                                    \=0A=
    typeof(*p) ___p1 =3D READ_ONCE(*p);                \=0A=
    compiletime_assert_atomic_type(*p);                \=0A=
    __smp_mb();                            \=0A=
    ___p1;                                \=0A=
})=0A=
=0A=
#define compiletime_assert_atomic_type(t)                \=0A=
    compiletime_assert(__native_word(t),                \=0A=
        "Need native word sized stores/loads for atomicity.")=0A=
=0A=
#define __native_word(t) \=0A=
    (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=3D sizeof(short) || \=
=0A=
     sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D sizeof(long))=0A=
=0A=
=0A=
So it won't catch the usage of 4 byte aligned long long which gcc targets t=
o=0A=
single double load instruction.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
