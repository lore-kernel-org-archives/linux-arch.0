From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 14/17] unicore32 machine related files: add i2c bus drivers for pkunity-v3 soc
Date: Mon, 28 Feb 2011 16:21:09 +0100
Message-ID: <201102281621.10091.arnd@arndb.de>
References: <cover.1298821856.git.epip@hera.kernel.org> <af52fefef7d120cd6bcdd10c115f276c445c45bf.1298821856.git.epip@hera.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59179 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab1B1PVU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2011 10:21:20 -0500
In-Reply-To: <af52fefef7d120cd6bcdd10c115f276c445c45bf.1298821856.git.epip@hera.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <epip@hera.kernel.org>
Cc: GuanXuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com

On Sunday 27 February 2011, Guan Xuetao wrote:
> From: GuanXuetao <gxt@mprc.pku.edu.cn>
> 
> change from original version -- by advice of Jean Delvare
> 1. remove global variable i2c_reg, replaced by local variables
> 2. replace ENXIO with ENODEV when no platform resources
> 3. add adapter->nr assignment before i2c_add_numbered_adapter() call
> 4. add judgement for i2c_del_adapter() return value
> 5. release adapter when driver removed
> 6. add __devexit for puv3_i2c_remove() function
> 7. modify several names to more appropriated ones
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Acked-by: Arnd Bergmann <arnd@arndb.de>
