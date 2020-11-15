Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D95C2D0E4
	for <linux-arch@archiver.kernel.org>; Sun, 15 Nov 2020 18:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB4122409
	for <linux-arch@archiver.kernel.org>; Sun, 15 Nov 2020 18:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cUJW6DSo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hc2OcVBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgKOSuZ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 15 Nov 2020 13:50:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36514 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgKOSuZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 Nov 2020 13:50:25 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605466223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8ZjbeFX8d6nq879izqAu1ChAOcTxw97ZdH3nLCQPVo=;
        b=cUJW6DSofkCJo/YgFNoH6wk8ld+g/Ro8rFC6SMfAUJllF6/f9gskD/OZ411dKtxl/d/cqg
        T4aZoJW/d5dqxel/O9EX8CFyZjwYlWk0NFoMVy5HCQj+7pJbQL99Mc5PwXpRCvHc+YV9Xm
        8Gne1lWo4sYSc3/H96IFz/hYOluv32E/KG5nKDzRJQjRlStBwBkGH+OkZ8htJFAH2+nPCi
        gYXyJEBxmqaeiolQnR9f3zOVMKuZI/HTfUkLPfqSGp4JuB614njHiFwwSqFLdm+7GQT4kE
        +niTmTL65Gt/Kjui+hfUh13C5GwTzurdnnuVFdODfu++x7dncQVQ0d37SyliCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605466223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8ZjbeFX8d6nq879izqAu1ChAOcTxw97ZdH3nLCQPVo=;
        b=hc2OcVBjh6N2TxPKldRV0wOOkKViTdsXr1oFXDvo5PssS8w+q809fHbmXpP3G12RBVh23j
        nrDfhniWURG7AgAA==
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     mingo@redhat.com, keescook@chromium.org, arnd@arndb.de,
        luto@amacapital.net, wad@chromium.org, rostedt@goodmis.org,
        paul@paul-moore.com, eparis@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH 00/10] Migrate syscall entry/exit work to SYSCALL_WORK flagset
In-Reply-To: <20201114032917.1205658-1-krisman@collabora.com>
References: <20201114032917.1205658-1-krisman@collabora.com>
Date:   Sun, 15 Nov 2020 19:50:22 +0100
Message-ID: <87pn4e8nf5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13 2020 at 22:29, Gabriel Krisman Bertazi wrote:
> This a refactor work moving the work done by features like seccomp,
> ptrace, audit and tracepoints out of the TI flags.  The reasons are:
>
>    1) Scarcity of TI flags in x86 32-bit.
>
>    2) TI flags are defined by the architecture, while these features are
>    arch-independent.
>
>    3) Community resistance in merging new architecture-independent
>    features as TI flags.
>
> The design exposes a new field in struct thread_info that is read at
> syscall_trace_enter and syscall_work_exit in place of the ti flags.
> No functional changes is expected from this patchset.  The design and
> organization of this patchset achieves the following goals:

Aside of the few nitpicks, this looks good. Thanks for doing this!

      tglx
