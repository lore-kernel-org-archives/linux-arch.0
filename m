Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32804 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbdAJWuC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2017 17:50:02 -0500
Message-ID: <58756510.4080301@gmail.com>
Date: Tue, 10 Jan 2017 22:49:52 +0000
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 03/10] m32r: migrate exception table users off module.h
 and onto extable.h
References: <20170109204010.5047-1-paul.gortmaker@windriver.com> <20170109204010.5047-4-paul.gortmaker@windriver.com>
In-Reply-To: <20170109204010.5047-4-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20170110224952.d-bs_cVh6ZrTVDsAK6MFVCkGPszkzb2PD0TtXU-hU_0@z>

On Monday 09 January 2017 08:40 PM, Paul Gortmaker wrote:
> These files were only including module.h for exception table
> related functions.  We've now separated that content out into its
> own file "extable.h" so now move over to that and avoid all the
> extra header content in module.h that we don't really need to compile
> these files.
>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


regards
sudip
