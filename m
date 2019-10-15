From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v9 07/28] x86/boot: Annotate local functions
Date: Tue, 15 Oct 2019 07:43:02 +0200
Message-ID: <0ece05d0-1942-4b9e-f6be-7a726961a471@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-8-jslaby@suse.cz> <20191014142742.GD4715@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191014142742.GD4715@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
