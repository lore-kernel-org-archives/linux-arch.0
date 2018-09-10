Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:34935 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbeIJXBh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Sep 2018 19:01:37 -0400
Date: Mon, 10 Sep 2018 20:06:13 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 03/16] x86/cpu/mtrr: Support TOP_MEM2 and get MTRR
 number
Message-ID: <20180910180613.GE4386@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <cdfcd79e88e0acf254347159673355eec00a1d37.1536550550.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdfcd79e88e0acf254347159673355eec00a1d37.1536550550.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180910180613.dvnXtHC67EgzZ7Wfg-yWzxJFiy9StQ3G7Gz7Q3ox4-c@z>

On Mon, Sep 10, 2018 at 09:16:03PM +0800, Pu Wen wrote:
> The Hygon Dhyana CPU have a special magic MSR way to force WB for
