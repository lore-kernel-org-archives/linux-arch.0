From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] asm-generic/io.h: Implement read[bwlq]_relaxed()
Date: Tue, 09 Sep 2014 14:11:53 +0100
Message-ID: <540EFC99.3040100@linaro.org>
References: <1410264760-29756-1-git-send-email-daniel.thompson@linaro.org> <CAMuHMdWvyfPxHKWD3MkgDQRaf4xQUzVq561C1BHiNC_stQ-Rqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:35105 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbaIINLv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Sep 2014 09:11:51 -0400
Received: by mail-wg0-f52.google.com with SMTP id x13so3358445wgg.11
        for <linux-arch@vger.kernel.org>; Tue, 09 Sep 2014 06:11:50 -0700 (PDT)
In-Reply-To: <CAMuHMdWvyfPxHKWD3MkgDQRaf4xQUzVq561C1BHiNC_stQ-Rqw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, Will Deacon <will.deacon@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>

On 09/09/14 13:31, Geert Uytterhoeven wrote:
> Hi Daniel,
> 
> On Tue, Sep 9, 2014 at 2:12 PM, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
>> Currently the read[bwlq]_relaxed() family are implemented on every
>> architecture except blackfin, m68k[1], metag, openrisc, s390[2] and
>> score. Increasingly drivers are being optimized to exploit relaxed
>> reads putting these architectures at risk of compilation failures for
>> shared drivers.
>>
>> This patch addresses this by providing implementations of
>> read[bwlq]_relaxed() that are identical to the equivalent read[bwlq]().
>> All the above architectures include asm-generic/io.h .
> 
> m68k does not include asm-generic/io.h.

Looking back through my command history I can't figure out how I made
this mistake.

I will change the comment.

For the record I have also just double checked blackfin, metag,
openrisc, s390 and score and these really do use asm-generic/io.h .


Daniel.
