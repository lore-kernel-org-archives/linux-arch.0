From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: [PATCH 01/10] Use __kernel_long_t in struct timex
Date: Thu, 17 May 2012 15:50:11 -0700
Message-ID: <4FB580A3.5010909@kernel.org>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <1337292816-10839-2-git-send-email-hjl.tools@gmail.com> <CA+55aFx98qvVg1JhMV0JjgNGb++xtir5ocseY3xgQNc3qAtWdQ@mail.gmail.com> <4FB57EB2.4050208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FB57EB2.4050208@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

On 05/17/2012 03:41 PM, H. Peter Anvin wrote:
> 
> That being said, this is a lot like the __u* and __s* types which we use
> instead of <stdint.h> for similar reasons.  I don't know if
> __ulong/__slong or __uword/__sword would be better here?
> 

Anyway - Linus, if you have a specific preference let me know and can
fix up these patches as well as the existing users in the kernel.

	-hpa
