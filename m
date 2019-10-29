Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38751 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2UhR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 16:37:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id v9so15132201wrq.5
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 13:37:15 -0700 (PDT)
Subject: Re: [PATCH 04/16] dyndbg: rename __verbose section to __dyndbg
References: <20191029200026.9790-1-jim.cromie@gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e9835376-1efe-1d1b-4a99-8bb920e04a08@rasmusvillemoes.dk>
Date: Tue, 29 Oct 2019 21:37:12 +0100
MIME-Version: 1.0
In-Reply-To: <20191029200026.9790-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc: greg@kroah.com, Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20191029203712.6w9bkzrtpGaHT-bNhtaN-H7gte-vTeCahgOP6-WlBJ8@z>

On 29/10/2019 21.00, Jim Cromie wrote:
> dyndbg populates its callsite info into __verbose section, change that
> to a more specific and descriptive name, __dyndbg.

Yeah, that has always bugged me. Ack to that part.

> Also, per checkpatch:
>   move extern struct _ddebug __(start|stop)__dyndbg[] to header file

Hm, why? checkpatch should often be ignored. Since we only refer to
those symbols in the .c file, there's no reason to pollute every other
translation unit with those declarations. Having declarations in a
header makes sense when the actual entity gets defined in some .c file
(which hopefully also includes the header). But these are defined by the
linker, so there's no type safety to be had.

>   simplify __attribute(..) to __section(__dyndbg) declaration.

Makes sense, since you're munching the thing anyway.

Rasmus
