Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:37760 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755970AbYAUDD3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 20 Jan 2008 22:03:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] kbuild: fix so modpost can now check any .o file
Date: Mon, 21 Jan 2008 11:56:31 +1100
References: <20080120200527.GA23852@uranus.ravnborg.org> <1200859743-24037-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1200859743-24037-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801211156.32122.rusty@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 21 January 2008 07:08:56 Sam Ravnborg wrote:
> It is very convinient to say:
> scripts/mod/modpost mm/built-in.o
>
> to check if any section mismatch errors occured
> in mm/ (as an example).

Hi Sam,

In an ideal world, wouldn't it be better to split out section analysis into a 
different helper program?

Cheers,
Rusty.
