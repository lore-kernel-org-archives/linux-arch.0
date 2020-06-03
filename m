From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v8 0/8] powerpc: switch VDSO to C implementation
Date: Wed, 03 Jun 2020 20:04:02 +1000
Message-ID: <87zh9kh3e5.fsf@mpe.ellerman.id.au>
References: <cover.1588079622.git.christophe.leroy@c-s.fr> <438ce3d7-aa0f-0284-7518-6c6339742aab@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:54135 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgFCKDm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Jun 2020 06:03:42 -0400
In-Reply-To: <438ce3d7-aa0f-0284-7518-6c6339742aab@csgroup.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de, vincenzo.frascino@arm.com, linuxppc-dev@lists.ozlabs.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Hi Michael,
>
> Le 28/04/2020 =C3=A0 15:16, Christophe Leroy a =C3=A9crit=C2=A0:
>> This is the seventh version of a series to switch powerpc VDSO to
>> generic C implementation.
>>=20
>> Main changes since v7 are:
>> - Added gettime64 on PPC32
>>=20
>> This series applies on today's powerpc/merge branch.
>>=20
>> See the last patches for details on changes and performance.
>
> Do you have any plans for this series ?

Review it and merge it one day :/

> Even if you don't feel like merging it this cycle, I think patches 1 to=20
> 3 are worth it.

I'd rather take the whole series for v5.9.

Sorry it missed this window, I just didn't get time to look at it.

cheers
