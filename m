From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/5] selftests/powerpc: Update the stack expansion test
Date: Tue, 07 Jul 2020 16:53:23 +1000
Message-ID: <87eepn4xzw.fsf@mpe.ellerman.id.au>
References: <20200703141327.1732550-1-mpe@ellerman.id.au> <20200703141327.1732550-3-mpe@ellerman.id.au> <8f6c5175-32ce-34a2-873d-b5fb3a5d7c4c@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgGGGvN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2020 02:51:13 -0400
In-Reply-To: <8f6c5175-32ce-34a2-873d-b5fb3a5d7c4c@csgroup.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@ozlabs.org
Cc: linux-arch@vger.kernel.org, hughd@google.com, linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 03/07/2020 =C3=A0 16:13, Michael Ellerman a =C3=A9crit=C2=A0:
>> Update the stack expansion load/store test to take into account the
>> new allowance of 4096 bytes below the stack pointer.
>
> [I didn't receive patch 2, don't know why, hence commenting patch 2 here.]
>
> Shouldn't patch 2 carry a fixes tag and be Cced to stable for=20
> application to previous kernel releases ?

Yes it should.

cheers
