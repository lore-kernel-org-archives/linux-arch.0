Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C42EFDA4;
	Wed, 21 Jan 2026 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957245; cv=none; b=GXQHDjsHLbJQJFUdaBk9CEQwhRIYhB0QF2LNn8ngP1TUi5cQ3DgLA7z+puj2bc6MSlwM35DcnGoeV2hPOxHVFTb7ZH/L3lUspoFpW1JjKDxbodOoC9m2qI8WV3Q0JEeANif5N1jAH3GxwFt0Tu9C6vSOr3jtJjrJO6EmjHnTGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957245; c=relaxed/simple;
	bh=MzDub15kx4+RkZmXdG0ckPzuS4X8/fxg9oHWd/CC8aU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUMNYaQ4tVPKed3870sdbW2lWzt5gLFQDc4/YpzFNP8JyQFQx7uBsiZHqNAHYPPV66QNgFy9D58VyXzmm7sdS0N++TYM5Wyq/SdYKEj6oHfA5dfb3zfRTQFeH31AXNdKd/H60fMXZKhSLasRvI/j5B49n6tZyZoPf401ADcWLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA0bYyp2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA0bYyp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1341C16AAE;
	Wed, 21 Jan 2026 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768957244;
	bh=MzDub15kx4+RkZmXdG0ckPzuS4X8/fxg9oHWd/CC8aU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NA0bYyp26JiVXF0eYyObuC0gPdk1ee4LW4sfuZck23GtJ/MDaYOYqdfRwjYX83tVC
	 AsdbEgLPqW8veMWqeP50f3nV7dOuAc4gmpGRQly+dOFUB8XJdNwOrCHiqB1GpJE3hp
	 mT0oEiS3lWC33E8NcydJ3kC3V/V9pQ1POXw02EMqzbhmnUm53fY6wgEVFEOWHwRYGt
	 jaXxtp+RqWv7Jtf+zTVpaN5W6jh4KpGJlI4ayO5v2SnYpzEbpsPaAZTkuAmNOrOJvU
	 eUmWZHT4/2Zd1no1GV6M1mmGt0XFNeopCyePXD+GdniF9f/9PFf7VWQaHSdPR0iQiM
	 l9Vt2tr3n9Bdg==
Date: Tue, 20 Jan 2026 17:00:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, David Ahern
 <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, Arnd Bergmann
 <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asml.silence@gmail.com,
 matttbe@kernel.org, skhawaja@google.com, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 3/5] net: devmem: implement autorelease
 token management
Message-ID: <20260120170042.43f038a2@kernel.org>
In-Reply-To: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-3-686d0af71978@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
	<20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-3-686d0af71978@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jan 2026 21:02:14 -0800 Bobby Eshleman wrote:
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index 596c306ce52b..a5301b150663 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -562,6 +562,17 @@ attribute-sets:
>          type: u32
>          checks:
>            min: 1
> +      -
> +        name: autorelease
> +        doc: |
> +          Token autorelease mode. If true (1), leaked tokens are automat=
ically
> +          released when the socket closes. If false (0), leaked tokens a=
re only
> +          released when the dmabuf is torn down. Once a binding is creat=
ed with
> +          a specific mode, all subsequent bindings system-wide must use =
the
> +          same mode.
> +
> +          Optional. Defaults to false if not specified.
> +        type: u8

if you plan to have more values - u32, if not - flag
u8 is 8b value + 24b of padding, it's only useful for proto fields

>  operations:
>    list:
> @@ -769,6 +780,7 @@ operations:
>              - ifindex
>              - fd
>              - queues
> +            - autorelease
>          reply:
>            attributes:
>              - id

>  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
> +static DEFINE_MUTEX(devmem_ar_lock);
> +DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
> +EXPORT_SYMBOL(tcp_devmem_ar_key);

I don't think you need the export, perhaps move the helper in here in
the first place (while keeping the static inline wrapper when devmem=3Dn)?

> +	if (autorelease)
> +		static_branch_enable(&tcp_devmem_ar_key);

This is user-controlled (non-root), right? So I think we need=20
the deferred version of key helpers.=20

> -	if (direction =3D=3D DMA_TO_DEVICE) {
> -		binding->vec =3D kvmalloc_array(dmabuf->size / PAGE_SIZE,
> -					      sizeof(struct net_iov *),
> -					      GFP_KERNEL);
> -		if (!binding->vec) {
> -			err =3D -ENOMEM;
> -			goto err_unmap;
> -		}
> +	binding->vec =3D kvmalloc_array(dmabuf->size / PAGE_SIZE,
> +				      sizeof(struct net_iov *),
> +				      GFP_KERNEL | __GFP_ZERO);

make it a kvcalloc() while we're touching it, pls

> +	if (!binding->vec) {
> +		err =3D -ENOMEM;
> +		goto err_unmap;
>  	}
> =20
>  	/* For simplicity we expect to make PAGE_SIZE allocations, but the
> @@ -306,25 +386,41 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  			niov =3D &owner->area.niovs[i];
>  			niov->type =3D NET_IOV_DMABUF;
>  			niov->owner =3D &owner->area;
> +			atomic_set(&niov->uref, 0);

Isn't it zero'ed during alloc?

>  			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
>  						      net_devmem_get_dma_addr(niov));
> -			if (direction =3D=3D DMA_TO_DEVICE)
> -				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] =3D niov;
> +			binding->vec[owner->area.base_virtual / PAGE_SIZE + i] =3D niov;
>  		}
> =20
>  		virtual +=3D len;
>  	}
> =20

> +	if (info->attrs[NETDEV_A_DMABUF_AUTORELEASE])
> +		autorelease =3D
> +			!!nla_get_u8(info->attrs[NETDEV_A_DMABUF_AUTORELEASE]);

nla_get_u8_default()=20

>  	priv =3D genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
>  	if (IS_ERR(priv))
>  		return PTR_ERR(priv);

> +static noinline_for_stack int
> +sock_devmem_dontneed_manual_release(struct sock *sk,
> +				    struct dmabuf_token *tokens,
> +				    unsigned int num_tokens)
> +{
> +	struct net_iov *niov;
> +	unsigned int i, j;
> +	netmem_ref netmem;
> +	unsigned int token;
> +	int num_frags =3D 0;
> +	int ret =3D 0;
> +
> +	if (!sk->sk_devmem_info.binding)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < num_tokens; i++) {
> +		for (j =3D 0; j < tokens[i].token_count; j++) {
> +			size_t size =3D sk->sk_devmem_info.binding->dmabuf->size;
> +
> +			token =3D tokens[i].token_start + j;
> +			if (token >=3D size / PAGE_SIZE)
> +				break;
> +
> +			if (++num_frags > MAX_DONTNEED_FRAGS)
> +				return ret;
> +
> +			niov =3D sk->sk_devmem_info.binding->vec[token];
> +			if (atomic_dec_and_test(&niov->uref)) {

Don't you need something like "atomic dec non zero and test" ?
refcount has refcount_dec_not_one() =F0=9F=A4=94=EF=B8=8F

> +				netmem =3D net_iov_to_netmem(niov);
> +				WARN_ON_ONCE(!napi_pp_put_page(netmem));
> +			}
> +			ret++;
> +		}

>  frag_limit_reached:
> -	xa_unlock_bh(&sk->sk_user_frags);
> +	xa_unlock_bh(&sk->sk_devmem_info.frags);

may be worth separating the sk_devmem_info change out for clarity

>  	for (k =3D 0; k < netmem_num; k++)
>  		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));

> @@ -2503,7 +2506,15 @@ void tcp_v4_destroy_sock(struct sock *sk)
> =20
>  	tcp_release_user_frags(sk);
> =20
> -	xa_destroy(&sk->sk_user_frags);
> +	if (!net_devmem_autorelease_enabled() && sk->sk_devmem_info.binding) {
> +		net_devmem_dmabuf_binding_user_put(sk->sk_devmem_info.binding);
> +		net_devmem_dmabuf_binding_put(sk->sk_devmem_info.binding);
> +		sk->sk_devmem_info.binding =3D NULL;
> +		WARN_ONCE(!xa_empty(&sk->sk_devmem_info.frags),
> +			  "non-empty xarray discovered in autorelease off mode");
> +	}
> +
> +	xa_destroy(&sk->sk_devmem_info.frags);

Let's wrap this up in a helper that'll live in devmem.c
