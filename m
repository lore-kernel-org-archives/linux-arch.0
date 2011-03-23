From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH RESEND 1/2] vsprintf: introduce %pT format specifier
Date: Wed, 23 Mar 2011 14:49:01 +0100
Message-ID: <AANLkTikidG=c7KvN4=QfwMwrPR8qCY3v4O7wKd8K8wdT@mail.gmail.com>
References: <20110323131213.GA25467@elte.hu>
	<1300886997-30781-1-git-send-email-namhyung@gmail.com>
	<1300887824.14261.130.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1300887824.14261.130.camel@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

2011/3/23 Steven Rostedt <rostedt@goodmis.org>:
> On Wed, 2011-03-23 at 22:29 +0900, Namhyung Kim wrote:
>> The %pT format specifier is for stack backtrace. Its handler
>> sprint_trace() does symbol lookup using (address-1) to ensure
>> the address will not point outside of the function.
>>
>> If there is a tail-call to the function marked "noreturn",
>> gcc optimized out the code after the call then causes saved
>> return address points outside of the function (i.e. the start
>> of the next function), so pollutes call trace somewhat.
>> This patch will fix it.
>>
>> before:
>> [ =A0 18.345923] Call Trace:
>> [ =A0 18.346001] =A0[<ffffffff812a8502>] panic+0x8c/0x18d
>> [ =A0 18.346257] =A0[<ffffffffa000012a>] deep01+0x0/0x38 [test_panic=
] =A0<--- bad
>> [ =A0 18.346347] =A0[<ffffffff81104666>] proc_file_write+0x73/0x8d
>> [ =A0 18.346432] =A0[<ffffffff811000b3>] proc_reg_write+0x8d/0xac
>> [ =A0 18.346516] =A0[<ffffffff810c7d32>] vfs_write+0xa1/0xc5
>> [ =A0 18.346603] =A0[<ffffffff810c7e0f>] sys_write+0x45/0x6c
>> [ =A0 18.346801] =A0[<ffffffff8f02943b>] system_call_fastpath+0x16/0=
x1b
>>
>> after:
>> [ =A0 22.224483] Call Trace:
>> [ =A0 22.224569] =A0[<ffffffff812bce69>] panic+0x8c/0x18d
>> [ =A0 22.224848] =A0[<ffffffffa000012a>] panic_write+0x20/0x20 [test=
_panic] =A0<--- ok
>> [ =A0 22.224979] =A0[<ffffffff81115fab>] proc_file_write+0x73/0x8d
>> [ =A0 22.225089] =A0[<ffffffff81111a5f>] proc_reg_write+0x8d/0xac
>> [ =A0 22.225199] =A0[<ffffffff810d90ee>] vfs_write+0xa1/0xc5
>> [ =A0 22.225304] =A0[<ffffffff810d91cb>] sys_write+0x45/0x6c
>> [ =A0 22.225408] =A0[<ffffffff812c07fb>] system_call_fastpath+0x16/0=
x1b
>
> Nice
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

Same for me:

Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
