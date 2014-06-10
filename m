From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 03/10] tools: Add le_direct/be_direct methods for
 unaligned access
Date: Tue, 10 Jun 2014 16:30:54 -0700
Message-ID: <5397952E.9040008@zytor.com>
References: <1402441994-16780-1-git-send-email-hpa@zytor.com> <1402441994-16780-4-git-send-email-hpa@zytor.com> <CALCETrUrdvvTc+qt61nQ1iRW4qpyDfMSzqnLKFMUsx7P=XvAfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CALCETrUrdvvTc+qt61nQ1iRW4qpyDfMSzqnLKFMUsx7P=XvAfA@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 06/10/2014 04:25 PM, Andy Lutomirski wrote:
> On Tue, Jun 10, 2014 at 4:13 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> For architectures which handle unaligned references transparently.
> 
> Shouldn't these depend on host endianness?
> 

See further down the series for how these end up being invoked.

	-hpa


