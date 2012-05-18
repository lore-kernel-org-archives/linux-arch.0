From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 05/21] resource: adjust_resource handle resource without parent
Date: Fri, 18 May 2012 11:12:07 -0600
Message-ID: <CAErSpo71rKrZ7ptJjE5Lb6YnrqXVe1eGhn3pyF2Qjp=o8JHQmg@mail.gmail.com>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org> <1336422606-4244-6-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50981 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757221Ab2ERRM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2012 13:12:29 -0400
Received: by lbbgm6 with SMTP id gm6so2220194lbb.19
        for <linux-arch@vger.kernel.org>; Fri, 18 May 2012 10:12:27 -0700 (PDT)
In-Reply-To: <1336422606-4244-6-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, May 7, 2012 at 2:29 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> for no parent no siling case.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
> =A0kernel/resource.c | =A0 13 ++++++++-----
> =A01 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 7e8ea66..51ade23 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -722,14 +722,12 @@ int adjust_resource(struct resource *res, resou=
rce_size_t start, resource_size_t
>
> =A0 =A0 =A0 =A0write_lock(&resource_lock);
>
> + =A0 =A0 =A0 if (!parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto skip;
> +
> =A0 =A0 =A0 =A0if ((start < parent->start) || (end > parent->end))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> - =A0 =A0 =A0 for (tmp =3D res->child; tmp; tmp =3D tmp->sibling) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((tmp->start < start) || (tmp->end >=
 end))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0if (res->sibling && (res->sibling->start <=3D end))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> @@ -741,6 +739,11 @@ int adjust_resource(struct resource *res, resour=
ce_size_t start, resource_size_t
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> +skip:
> + =A0 =A0 =A0 for (tmp =3D res->child; tmp; tmp =3D tmp->sibling)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((tmp->start < start) || (tmp->end >=
 end))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> =A0 =A0 =A0 =A0res->start =3D start;
> =A0 =A0 =A0 =A0res->end =3D end;
> =A0 =A0 =A0 =A0result =3D 0;

Where does this case occur?  When do you need to adjust a resource
that has no parent?
