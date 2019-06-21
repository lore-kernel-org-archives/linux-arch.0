Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:40226 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726196AbfFUPjb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 11:39:31 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: RE: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Date: Fri, 21 Jun 2019 15:39:27 +0000
Message-ID: <CY4PR1201MB0120D86E5774F93769320B59A1E70@CY4PR1201MB0120.namprd12.prod.outlook.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
 <20190620075224.GT3419@hirez.programming.kicks-ass.net>
 <9192bd26-5f34-dcbf-8552-2f474866a31e@synopsys.com>
In-Reply-To: <9192bd26-5f34-dcbf-8552-2f474866a31e@synopsys.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jason Baron <jbaron@akamai.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Message-ID: <20190621153927.a_ZGwrAR4xMCqVVetqlFPPRu97ByZtZr8SxKqELRIp0@z>

Hi Vineet,

> -----Original Message-----
> From: linux-snps-arc <linux-snps-arc-bounces@lists.infradead.org> On Beha=
lf Of Vineet Gupta
> Sent: Thursday, June 20, 2019 11:50 PM
> To: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org; Ard Biesheuvel <ard.biesheuvel@linaro.org=
>; Alexey Brodkin
> <abrodkin@synopsys.com>; linux-kernel@vger.kernel.org; Jason Baron <jbaro=
n@akamai.com>; Paolo Bonzini
> <pbonzini@redhat.com>; linux-snps-arc@lists.infradead.org; Eugeniy Paltse=
v
> <Eugeniy.Paltsev@synopsys.com>
> Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patchin=
g

[snip]

> Insn encoding is always middl eendina - irrespective of endianness.

Apparently only in little-endian mode instructions are encoded as middle-en=
dian,
see:
-------------->8-------------
# cat endian.S

.global myfunc
myfunc:
        mov r0, r1
-------------->8-------------

Little-endian:
-------------->8-------------
# arc-linux-gcc -c -mcpu=3Darchs endian.S -EL
# arc-linux-objdump -d endian.o

endian.o:     file format elf32-littlearc

Disassembly of section .text:
00000000 <myfunc>:
   0:   200a 0040               mov     r0,r1

# arc-linux-readelf -x .text endian.o
Hex dump of section '.text':
  0x00000000 0a204000                            . @.
-------------->8-------------

Big-endian:
-------------->8-------------
# arc-linux-gcc -c -mcpu=3Darchs endian.S -EB
# arc-linux-objdump -d endian.o

endian.o:     file format elf32-bigarc

Disassembly of section .text:
00000000 <myfunc>:
   0:   200a 0040               mov     r0,r1

# arc-linux-readelf -x .text endian.o

Hex dump of section '.text':
  0x00000000 200a0040                             ..@
-------------->8-------------

-Alexey
