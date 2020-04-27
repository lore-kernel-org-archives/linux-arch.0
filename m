Return-Path: <SRS0=jgxL=6L=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgD0JAN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2020 05:00:13 -0400
Date: Mon, 27 Apr 2020 11:00:05 +0200 (CEST)
From: Hagen Paul Pfeifer <hagen@jauu.net>
Reply-To: Hagen Paul Pfeifer <hagen@jauu.net>
Message-ID: <2008370628.171531.1587978005102@office.mailbox.org>
In-Reply-To: <CAK8P3a1qdyw+5B-E52O42VEWvpq_6jF74__ptM+q6SoKd3pkuA@mail.gmail.com>
References: <20200426130100.306246-1-hagen@jauu.net>
 <20200426163430.22743-1-hagen@jauu.net>
 <CAK8P3a1qdyw+5B-E52O42VEWvpq_6jF74__ptM+q6SoKd3pkuA@mail.gmail.com>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, David Howells <dhowells@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Sargun Dhillon <sargun@sargun.me>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20200427090005.j828ET97Vh-cXFs9nZsqmuvnSqCVQCgYbPAGCLM6gDg@z>

> On April 27, 2020 10:30 AM Arnd Bergmann <arnd@arndb.de> wrote:

Hey Arnd

> When you add a new system call, please add it to all architectures.
> See the patches for the last few additions on how to do it, in
> particular the bit around adding the arm64 compat entry that is
> a bit tricky.

Yes, the patch was intended to be as an rough (but x86_64 working)
RFC patch to basically check if there is interest in it. Or whether
there are fundamental reasons against pidfd_ptrace().

If not I will prepare v3 with all input, sure! Thank you Arnd

Hagen
