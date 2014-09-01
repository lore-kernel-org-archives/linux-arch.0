Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:53836 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbaIALnH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Sep 2014 07:43:07 -0400
Received: by mail-yh0-f43.google.com with SMTP id f73so3326661yha.16
        for <linux-arch@vger.kernel.org>; Mon, 01 Sep 2014 04:43:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140828152320.GN22580@arm.com>
References: <1409237107-24228-1-git-send-email-steve.capper@linaro.org>
	<20140828152320.GN22580@arm.com>
Date: Mon, 1 Sep 2014 12:43:06 +0100
Message-ID: <CAPvkgC0YVhPEBqbWSDnGyZBUn3+8Kv7-yx1-_n0Jx+giKzOqmw@mail.gmail.com>
Subject: Re: [PATCH V3 0/6] RCU get_user_pages_fast and __get_user_pages_fast
From: Steve Capper <steve.capper@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>, "mgorman@suse.de" <mgorman@suse.de>
Message-ID: <20140901114306.yo74-bC_Bw4Bwox6CV6A1QPTmyFeMYT34o7FlCCF43M@z>

On 28 August 2014 16:23, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Aug 28, 2014 at 03:45:01PM +0100, Steve Capper wrote:
>> I would like to get this series into 3.18 as it fixes quite a big problem
>> with THP on arm and arm64. This series is split into a core mm part, an
>> arm part and an arm64 part.
>>
>> Could somebody please take patch #1 (if it looks okay)?
>> Russell, would you be happy with patches #2, #3, #4? (if we get #1 merged)
>> Catalin, would you be happy taking patches #5, #6? (if we get #1 merged)
>
> Pretty sure we're happy to take the arm64 bits once you've got the core
> changes sorted out. Failing that, Catalin's acked them so they could go via
> an mm tree if it's easier.
>

Hello,

Are any mm maintainers willing to take the first patch from this
series into their tree for merging into 3.18?
  mm: Introduce a general RCU get_user_pages_fast.

(or please let me know if there are any issues with the patch that
need addressing).

As Will has stated, Catalin's already acked the arm64 patches, and
these can also go in via an mm tree if that makes things easier:
  arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
  arm64: mm: Enable RCU fast_gup

Thanks,
--
Steve
