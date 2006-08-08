Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:18319 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964871AbWHHM2X (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2006 08:28:23 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 13/13] Generic ioremap_page_range: x86_64 conversion
Date: Tue, 8 Aug 2006 14:28:11 +0200
References: <11550397951750-git-send-email-hskinnemoen@atmel.com> <11550397961392-git-send-email-hskinnemoen@atmel.com> <11550397963540-git-send-email-hskinnemoen@atmel.com>
In-Reply-To: <11550397963540-git-send-email-hskinnemoen@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081428.11276.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 08 August 2006 14:23, Haavard Skinnemoen wrote:
> Convert x86_64 to use generic ioremap_page_range()

Ok for me.  Also i386.

But linux-arch is normally not for patches, just for discussion.
You should send the mails directly to the responsible people, probably
cc l-k.

-Andi
