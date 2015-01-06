Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52711 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbbAFTJG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jan 2015 14:09:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 00/40] uaccess: fix sparse warning on get/put_user for bitwise types
Date: Tue, 06 Jan 2015 20:08:57 +0100
Message-ID: <4461163.Sc5FsMDTBa@wuerfel>
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150106190857.nOi_oJVN8DcgEGJ_IVGrb27Wzs8nSVaRxoc-6B7ECnU@z>

On Tuesday 06 January 2015 17:43:28 Michael S. Tsirkin wrote:
> 
> I tested this on x86 only. Since it's just adding __force, should be
> trivially safe everywhere?
> 
> 
> Arnd, did you merge v1 already? If yes, can you please replace with
> this version?
> 

I haven't merged it yet. I see that more Acks and some comments are
coming in. Once those are done, could you send a pull request? It
might be useful to have a branch that can be shared with architecture
trees if necessary to avoid merge conflicts.

	Arnd
