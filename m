From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 3/3] thread_info: include <current.h> for THREAD_INFO_IN_TASK
Date: Thu, 27 Oct 2016 16:13:49 -0700
Message-ID: <CALCETrUqApnWBwFPwkToTp1_Wm68tbPAW=UH+X5mZrNS+3rHjA@mail.gmail.com>
References: <1476901693-8492-1-git-send-email-mark.rutland@arm.com> <1476901693-8492-4-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476901693-8492-4-git-send-email-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Andrew Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 19, 2016 at 11:28 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> When CONFIG_THREAD_INFO_IN_TASK is selected, the current_thread_info()
> macro relies on current having been defined prior to its use. However,
> not all users of current_thread_info() include <asm/current.h>, and thus
> current is not guaranteed to be defined.
>
> When CONFIG_THREAD_INFO_IN_TASK is not selected, it's possible that
> get_current() / current are based upon current_thread_info(), and
> <asm/current.h> includes <asm/thread_info.h>. Thus always including
> <asm/current.h> would result in circular dependences on some platforms.
>
> To ensure both cases work, this patch includes <asm/current.h>, but only
> when CONFIG_THREAD_INFO_IN_TASK is selected.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

although it would be nice if you moved your description of why the
include is conditional into a comment.

--Andy
