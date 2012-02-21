From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH 30/30] x32: Add x32 VDSO support
Date: Tue, 21 Feb 2012 11:40:38 -0800
Message-ID: <CAObL_7H=M7-wxobKkj+K2fcrpEv0Nfp8=6gV2yvdb2hqxCTAGg@mail.gmail.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com>
 <1329696488-16970-31-git-send-email-hpa@zytor.com> <4F42E171.9080005@mit.edu>
 <4F431665.3010004@zytor.com> <CAObL_7Hy8Y0PWrcZdRSGRcEt+aoma7ax4XU44f-gdHEGoWBzTg@mail.gmail.com>
 <4F43D98D.1020406@zytor.com> <CAObL_7GqT-CSB6uBoDvKymodEzUi3tY0DJv0U=xzYbaJS7A1nA@mail.gmail.com>
 <4F43EA83.6020203@zytor.com> <CAObL_7GLnDFkb61jAZEj+9gGTr4FA=8ZFVMxd9Tus4LVVmKjKw@mail.gmail.com>
 <4F43F25E.3030004@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F43F25E.3030004@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 21, 2012 at 11:37 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 02/21/2012 11:29 AM, Andrew Lutomirski wrote:
>>>
>>> The vsyscall page shouldn't be mapped for x32 tasks...
>>
>> How is that possible? =A0It lives in the fixmap and is presumably
>> visible from any 64-bit code.
>>
>> Admittedly, x32 tasks are probably somewhat difficult to trick into
>> calling addresses with high bits set, but it's not necessarily
>> impossible.
>>
>
> Fair enough, and it's not necessarily all that hard either.
>
> And it's visible even in a 32-bit task, although a 32-bit task has to
> switch into 64-bit mode. =A0Yet another reason the vsyscall page need=
s to die.
>
> I was having delusions that we could have a task-owned PDT in negativ=
e
> space, but that would require unsharing the third level, too, which i=
s
> just way too messy.

I'd like to do that, too, and I'd also like to have a per-cpu
kernel-only page in there, but that's even worse.  If we had a
separate cr3-like register for negative addresses, life would be good
:)

--Andy
