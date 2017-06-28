From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] arch: remove unused macro/function thread_saved_pc()
Date: Wed, 28 Jun 2017 16:14:42 -0700
Message-ID: <CA+55aFxUjTQmhovCVHQTPw+v8+P+D8X+LoBohG5sY6cYhtknaQ@mail.gmail.com>
References: <20170628133003.17432-1-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170628133003.17432-1-tklauser@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 28, 2017 at 6:30 AM, Tobias Klauser <tklauser@distanz.ch> wrote:
> The only user of thread_saved_pc() in non-arch-specific code was removed
> in commit 8243d5597793 ("sched/core: Remove pointless printout in
> sched_show_task()"). Remove the implementations as well.
>
> Some architectures use thread_saved_pc() in their arch-specific code.
> Leave their thread_saved_pc() intact.

Applied.

I do like applying patches that just remove lines of code. Sadly, it's
not very common.

                Linus
