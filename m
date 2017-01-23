From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 13/20] arc: migrate exception table users off module.h and
 onto extable.h
Date: Mon, 23 Jan 2017 13:14:04 -0800
Message-ID: <b8c3cef5-ad62-1e2f-499c-b80816a88469@synopsys.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
 <20170122163244.11740-14-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:43217 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbdAWVON (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2017 16:14:13 -0500
In-Reply-To: <20170122163244.11740-14-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org

On 01/22/2017 08:32 AM, Paul Gortmaker wrote:
> This file was only including module.h for exception table related
> functions.  We've now separated that content out into its own file
> "extable.h" so now move over to that and avoid all the extra header
> content in module.h that we don't really need to compile this file.
> Since the file does have some EXPORT_SYMBOL, we add export.h include.
> 
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: linux-snps-arc@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Thx,
-Vineet
