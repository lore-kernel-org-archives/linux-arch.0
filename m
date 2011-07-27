From: "=?iso-8859-15?q?R=E9mi?= Denis-Courmont"
	<remi.denis-courmont@nokia.com>
Subject: Re: [PATCHv4 11/11] Phonet: Use *_dec_not_zero instead of *_add_unless
Date: Wed, 27 Jul 2011 13:29:43 +0300
Message-ID: <201107271329.44069.remi.denis-courmont@nokia.com>
References: <1311760070-21532-1-git-send-email-sven@narfation.org> <1311760070-21532-11-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:46369 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867Ab1G0K3l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jul 2011 06:29:41 -0400
In-Reply-To: <1311760070-21532-11-git-send-email-sven@narfation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Wednesday 27 July 2011 12:47:50 ext Sven Eckelmann, you wrote:
> atomic_dec_not_zero is defined for each architecture through
> <linux/atomic.h> to provide the functionality of
> atomic_add_unless(x, -1, 0).
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Cc: Remi Denis-Courmont <remi.denis-courmont@nokia.com>

Acked-by: R=E9mi Denis-Courmont <remi.denis-courmont@nokia.com>

> ---
>  net/phonet/pep.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/net/phonet/pep.c b/net/phonet/pep.c
> index f17fd84..b192c83 100644
> --- a/net/phonet/pep.c
> +++ b/net/phonet/pep.c
> @@ -1013,7 +1013,7 @@ static int pipe_skb_send(struct sock *sk, struc=
t
> sk_buff *skb) int err;
>=20
>  	if (pn_flow_safe(pn->tx_fc) &&
> -	    !atomic_add_unless(&pn->tx_credits, -1, 0)) {
> +	    !atomic_dec_not_zero(&pn->tx_credits)) {
>  		kfree_skb(skb);
>  		return -ENOBUFS;
>  	}


--=20
R=E9mi Denis-Courmont
http://www.remlab.net/
