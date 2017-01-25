Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:55367 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751630AbdAYJxY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Jan 2017 04:53:24 -0500
Date: Wed, 25 Jan 2017 10:53:20 +0100
From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 12/20] nios2: migrate exception table users off module.h
 and onto extable.h
Message-ID: <20170125095320.GD27277@distanz.ch>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
 <20170122163244.11740-13-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170122163244.11740-13-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Message-ID: <20170125095320.UW6AkqQIHg8xTPv42e89jfxcjcABRy2dm862WPcO7I4@z>

On 2017-01-22 at 17:32:36 +0100, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> This file was only including module.h for exception table related
> functions.  We've now separated that content out into its own file
> "extable.h" so now move over to that and avoid all the extra header
> content in module.h that we don't really need to compile this file.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: nios2-dev@lists.rocketboards.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>
