From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 40/40] xtensa: macro whitespace fixes
Date: Wed, 7 Jan 2015 02:12:39 +0300
Message-ID: <CAMo8Bf+omBm1DkfHYiidcY54b+-cRe2CEx1S_17OL70-K7hHJw@mail.gmail.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
	<1420558883-10131-41-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:45238 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbbAFXMk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jan 2015 18:12:40 -0500
In-Reply-To: <1420558883-10131-41-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Chris Zankel <chris@zankel.net>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>

On Tue, Jan 6, 2015 at 6:45 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> While working on arch/xtensa/include/asm/uaccess.h, I noticed
> that some macros within this header are made harder to read because they
> violate a coding style rule: space is missing after comma.
>
> Fix it up.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/xtensa/include/asm/uaccess.h | 90 +++++++++++++++++++--------------------
>  1 file changed, 45 insertions(+), 45 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
