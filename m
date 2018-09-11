Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:37448 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeIKPuK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Sep 2018 11:50:10 -0400
Date: Tue, 11 Sep 2018 12:51:20 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 15/16] EDAC, amd64: Add Hygon Dhyana support
Message-ID: <20180911105120.GH12094@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <7deadc44054d62e3617b9f302f4e5d1fd0d382e7.1536550550.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7deadc44054d62e3617b9f302f4e5d1fd0d382e7.1536550550.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de
Cc: Pu Wen <puwen@hygon.cn>, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, mchehab@kernel.org, mikhail.jin@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180911105120.K3XAfwg-RqU-rPruuHkLYfyXIAweCnAScavqGjVonHg@z>

On Mon, Sep 10, 2018 at 09:20:24PM +0800, Pu Wen wrote:
> To make AMD64 EDAC and MCE drivers working on Hygon platforms, add
> support for Hygon Dhyana CPU by using the code path of AMD family
> 17h.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  drivers/edac/amd64_edac.c | 8 +++++++-
>  drivers/edac/mce_amd.c    | 4 +++-
>  2 files changed, 10 insertions(+), 2 deletions(-)

This one conflicts with

  8960de4a5ca7 ("EDAC, amd64: Add Family 17h, models 10h-2fh support")

in my tree.

tglx, what do you suggest?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
