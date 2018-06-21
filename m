Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:40556 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933110AbeFUNFQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jun 2018 09:05:16 -0400
Date: Thu, 21 Jun 2018 15:05:11 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 5/5] Documentation/x86: Add CET description
Message-ID: <20180621130511.GA7895@gmail.com>
References: <20180607143544.3477-1-yu-cheng.yu@intel.com>
 <20180607143544.3477-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607143544.3477-6-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <20180621130511.MErHlT-Oq147_fNKGBJwVCiLsOYJ6We4eom1FEdv1kI@z>


* Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

> +Control Flow Enforcement Technology (CET) provides protection against
> +return/jump-oriented programing (ROP) attacks.

So the obvious abbreviation would be CFT or CFET.

Exactly why is 'CET' used, which not only has very little to do with what it's 
supposed to mean, but is also a well-known timezone, Central European Time?

Thanks,

	Ingo
