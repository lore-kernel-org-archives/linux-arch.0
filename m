Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54588 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab1C3JcI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2011 05:32:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] unicore32 ldscript fix: add cacheline parameter to PERCPU() macro
Date: Wed, 30 Mar 2011 11:31:58 +0200
References: <01ed01cbeeb7$de2e1920$9a8a4b60$@mprc.pku.edu.cn>
In-Reply-To: <01ed01cbeeb7$de2e1920$9a8a4b60$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201103301131.59054.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20110330093158.OnjmMT5Jrrbh_av7dQmoXzCYdpa9xHo1x3Zxz8XUWfA@z>

On Wednesday 30 March 2011, Guan Xuetao wrote:
> 
> Also, adjust cacheline parameter of RW_DATA_SECTION and EXCEPTION_TABLE
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Acked-by: Arnd Bergmann <arnd@arndb.de>
