Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from m12-14.163.com ([220.181.12.14]:34575 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfKMHRV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Nov 2019 02:17:21 -0500
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com>
 <20191112123125.GD17835@willie-the-truck>
 <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
 <32a3b660-f4d2-268e-2206-d50073298c0c@iogearbox.net>
 <CAK7LNASR=R=gyuaMO=VzdXrY3gaQ_FVE4es60bzXf=9ASR2qUw@mail.gmail.com>
 <021e7b46-047e-d381-9dca-bd61db08e4f8@163.com>
 <CAK7LNARKh3-cAqsYgcxFwq9CGk-CgBfkiQgfNSULkxwO0xa2vw@mail.gmail.com>
From: Xiao Yang <ice_yangxiao@163.com>
Message-ID: <ac4577d4-c0f2-9596-df6f-3fcc563bde3e@163.com>
Date: Wed, 13 Nov 2019 15:16:37 +0800
MIME-Version: 1.0
In-Reply-To: <CAK7LNARKh3-cAqsYgcxFwq9CGk-CgBfkiQgfNSULkxwO0xa2vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Message-ID: <20191113071637.xcwih6qJX2CdOo5fOIAn1hKkciuqfUTxM866R99K1JU@z>

On 11/13/19 2:57 PM, Masahiro Yamada wrote:
> Sorry, I really do not understand what you are doing.
>
> include/linux/compiler.h is only for kernel-space.
> Shrug if a user-land program includes it.

Hi Masahiro,

For building tools/bpf, it is good to fix the compiler error by Daniel's 
patch(i.e. use linux/filter from linux header).

linux/compiler.h may be used by other code in kernel.  Is it possible to 
trigger the same error when the other code

including linux/compiler.h is built? Is this kind of code able to find 
the location of <asm/rwonce.h>?

Best Regards,

Xiao Yang
