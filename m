Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34988 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdF1XOo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 19:14:44 -0400
MIME-Version: 1.0
In-Reply-To: <20170628133003.17432-1-tklauser@distanz.ch>
References: <20170628133003.17432-1-tklauser@distanz.ch>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Jun 2017 16:14:42 -0700
Message-ID: <CA+55aFxUjTQmhovCVHQTPw+v8+P+D8X+LoBohG5sY6cYhtknaQ@mail.gmail.com>
Subject: Re: [PATCH] arch: remove unused macro/function thread_saved_pc()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Message-ID: <20170628231442.dCR9is81IwlaP_KBmHdTf2bZrEMZOdmVM1kHxIgyIGI@z>

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
