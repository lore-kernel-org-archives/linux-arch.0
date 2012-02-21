From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH 30/30] x32: Add x32 VDSO support
Date: Tue, 21 Feb 2012 11:51:23 -0800
Message-ID: <CAObL_7FW7qr5cOpB=kcPaQQUgPAebm+WgzevTW8j83WKV3dFDQ@mail.gmail.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com>
 <1329696488-16970-31-git-send-email-hpa@zytor.com> <4F42E171.9080005@mit.edu>
 <4F431665.3010004@zytor.com> <CAObL_7Hy8Y0PWrcZdRSGRcEt+aoma7ax4XU44f-gdHEGoWBzTg@mail.gmail.com>
 <4F43D98D.1020406@zytor.com> <CAObL_7GqT-CSB6uBoDvKymodEzUi3tY0DJv0U=xzYbaJS7A1nA@mail.gmail.com>
 <4F43EA83.6020203@zytor.com> <CAObL_7GLnDFkb61jAZEj+9gGTr4FA=8ZFVMxd9Tus4LVVmKjKw@mail.gmail.com>
 <4F43F25E.3030004@zytor.com> <CAObL_7H=M7-wxobKkj+K2fcrpEv0Nfp8=6gV2yvdb2hqxCTAGg@mail.gmail.com>
 <4F43F54D.50201@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F43F54D.50201@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 21, 2012 at 11:49 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 02/21/2012 11:40 AM, Andrew Lutomirski wrote:
>>>
>>> I was having delusions that we could have a task-owned PDT in negat=
ive
>>> space, but that would require unsharing the third level, too, which=
 is
>>> just way too messy.
>>
>> I'd like to do that, too, and I'd also like to have a per-cpu
>> kernel-only page in there, but that's even worse. =A0If we had a
>> separate cr3-like register for negative addresses, life would be goo=
d
>> :)
>>
>
> No, that wouldn't help. =A0The situation is actually quite similar to=
 the
> current situation where we have an unshared fourth level, but since t=
he
> fourth entries are 512G per entry, we would have to push unsharing of
> the kernel address space at least one more level (1G), possibly two
> (2M). =A0Painful.
>
> The main advantage of a separate cr3 would be that we wouldn't need t=
he
> unshared top level for the kernel side.

Also, as is, if the top level wants to be per-cpu *and* per-task,
that's a big explosion of page tables that all need to stay in sync.

Oh well.

--Andy
