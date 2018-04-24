From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault
 in relay_signal.
Date: Tue, 24 Apr 2018 09:44:22 +0100
Message-ID: <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk>
References: <87604mhrnb.fsf@xmission.com>
 <20180420143811.9994-19-ebiederm@xmission.com>
 <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
 <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-Id: linux-arch.vger.kernel.org

Hi Richard,

There was a post to uml-devel during the days when the sourceforge 
mailing list was working in random drop mode which claimed that "this 
fixes the arm build".

I have not kept it locally and I do not see it the archive (I do not see 
a few other posts there either - including some of mine).

The joys of having a broken list :(

Whoever posted it, if you are reading it, please re-post again so we can 
have a look.

In the meantime we are as you said - x86 only.

A.

On 04/24/18 09:32, Richard Weinberger wrote:
> On Fri, Apr 20, 2018 at 6:06 PM, Anton Ivanov
> <anton.ivanov@kot-begemot.co.uk> wrote:
>> On 04/20/18 15:38, Eric W. Biederman wrote:
>>> Today user mode linux only works on x86 and x86_64 and this allows
>>> simplifications of relay_signal.
>>
>> I believe someone recently fixed the ARM port. I have not had the time to
>> try the fixes though.
> Huh? UML is for ages x86 only.
>
