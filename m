Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54418 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfJOFnH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Oct 2019 01:43:07 -0400
Subject: Re: [PATCH v9 07/28] x86/boot: Annotate local functions
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-8-jslaby@suse.cz> <20191014142742.GD4715@zn.tnic>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <0ece05d0-1942-4b9e-f6be-7a726961a471@suse.cz>
Date: Tue, 15 Oct 2019 07:43:02 +0200
MIME-Version: 1.0
In-Reply-To: <20191014142742.GD4715@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20191015054302.VQVQ36v1izQKcfpWOx0oxBc5FKuR4OrAeQNj_iClssc@z>

On 14. 10. 19, 16:27, Borislav Petkov wrote:
> On Fri, Oct 11, 2019 at 01:50:47PM +0200, Jiri Slaby wrote:
>> .Lrelocated, .Lpaging_enabled, .Lno_longmode, and .Lin_pm32 are
>> self-standing local functions, annotate them as such and preserve "no
>> alignment".
>>
>> The annotations do not generate anything yet.
> 
> So the annotation is only documentational, right?

Right.

thanks,
-- 
js
suse labs
