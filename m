Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omzsmtpe03.verizonbusiness.com ([199.249.25.208]:22654 "EHLO
        omzsmtpe03.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751732AbdKWBOm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Nov 2017 20:14:42 -0500
From: alexander.levin@verizon.com
Subject: Re: [PATCH AUTOSEL for 4.14 45/51] locking/refcounts, x86/asm: Use
 unique .text section for refcount exceptions
Date: Thu, 23 Nov 2017 01:13:54 +0000
Message-ID: <20171123011351.qoxpylb4ockkfss7@sasha-lappy>
References: <20171122222526.20021-1-alexander.levin@verizon.com>
 <20171122222526.20021-45-alexander.levin@verizon.com>
 <CAGXu5jLo+Qi8Opze7U6gaVDa2U7tRj44U9qxaPPW+yP1eOYPJg@mail.gmail.com>
In-Reply-To: <CAGXu5jLo+Qi8Opze7U6gaVDa2U7tRj44U9qxaPPW+yP1eOYPJg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <43F1D2B84CC9D145BEDF52AF415039F2@vzwcorp.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Elena <elena.reshetova@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Message-ID: <20171123011354.n9DfafvndZUcVFR25dc5bOhyISRdvlzC4_vpnQ2-uOg@z>

On Wed, Nov 22, 2017 at 03:19:10PM -0800, Kees Cook wrote:
>Hi,
>
>On Wed, Nov 22, 2017 at 2:25 PM,  <alexander.levin@verizon.com> wrote:
>> From: Kees Cook <keescook@chromium.org>
>>
>> [ Upstream commit 564c9cc84e2adf8a6671c1937f0a9fe3da2a4b0e ]
>
>Thanks! I was going to recommend this too. Please also add:
>
>commit 39208aa7ecb7 ("locking/refcounts, x86/asm: Enable
>CONFIG_ARCH_HAS_REFCOUNT")

Added, thanks!

--=20

Thanks,
Sasha=
