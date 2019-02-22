Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41623 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfBVUyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Feb 2019 15:54:03 -0500
MIME-Version: 1.0
References: <1550748991-14362-1-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1550748991-14362-1-git-send-email-rppt@linux.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Feb 2019 21:53:44 +0100
Message-ID: <CAK8P3a03ACXyehHTxtefinwEsNbA9F4Ap28SGAFqeA2W_9pq6A@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/page.h: fix typo in #error text requiring a
 real asm/page.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190222205344.GmZumVJE5KpheTPNova-J-cMzbdCXrOe6VY0V4RJ7d4@z>

On Thu, Feb 21, 2019 at 12:36 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Replace "need to prove a real asm/page.h" with "need to provide a real
> asm/page.h"
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Applied, thanks!

      Arnd
