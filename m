From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 25/28] nios2: ptrace support
Date: Mon, 28 Apr 2014 14:03:00 +0800
Message-ID: <CAFiDJ58W+BkjqYurWTdWhoOJjOMBGzvnRvxjKeyJVKCJHkNMGA@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-22-git-send-email-lftan@altera.com>
	<535AF527.80601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <535AF527.80601@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Pedro Alves <palves@redhat.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Sat, Apr 26, 2014 at 7:52 AM, Pedro Alves <palves@redhat.com> wrote:
> Does this support PTRACE_GETREGSET / PTRACE_SETREGSET ?
>
> IMO, the kernel shouldn't accept ports without those anymore.
>
> And IMHO, we shouldn't even allow new ports having PTRACE_GETREGS.
>
> http://sourceware.org/ml/archer/2010-q3/msg00193.html
>

It doesn't support PTRACE_GETREGSET / PTRACE_SETREGSET now.
We will look into this.

Regards
Ley Foon
