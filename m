Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD03F23CC
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973637; cv=none; b=oNR4+5NaL0gDF5U+3CW832fj77UCncsLuKAQrKXb99wjGZrATNBB2P0cPCeCStxgCU07jNHyvaAEXjiBJlMvyaiCrdRvJJPNjBFCGJgQr+Ny4cEYFRJG7poz5ICV+HPw+CQHvkmINsij4zm4sugvQ5yP6JUBdvIAVJam1O0sWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973637; c=relaxed/simple;
	bh=Cc7McXfM53XA8joxZklxQZYIsEwBSDIZEKAZdeQ/7uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esDfnfS9gH/2nPwNCrt9kvWnX0cZjj/x7fZpCOG3FoRw5HSqt6+gcSks/m++jZo2CHc0FFh0fykeTq6UK215r/YgXGPqFiux8sHyJq2UVfzwqnQ5J+mFvYHE5g/2+8uY7kbiyp94PWNZVe1Hw2ijKEE0x0yqLCWwMY8TujzYfuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgGlOLU4; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgGlOLU4"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79088484065so57511517b3.1
        for <linux-arch@vger.kernel.org>; Tue, 20 Jan 2026 21:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768973634; x=1769578434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h3UPoz+4dGK8MYLy8d1alrE5wWkl0RR3HxeTS6m1CsA=;
        b=KgGlOLU4yDh8kc9AiUI757njsyokT4Cf6fA044cNwggVqLkn/noDq7sgLa4FFh9SXJ
         5t0AiKNmm1aYLVBOxsOO+DTwSmZRjmoUM3YliUtA2tsQBfxywqA7JjMmlLWU6uJpUSwo
         H+i8ILusCJJXN7jV1vuBW93OOjwpkNvG1H2zvqEjd0XHFqza+FZgOXMmnNLI/iPaqL8N
         L48c2lUQSoS/aNWjQWRBhJi6DolKn1xVk8+O9oELIQz0fCYqi/usqQFUqUF04c9quZQ0
         wBnWiGFjTJ87Qm+E8SeCRl64996aYaOwZ+wunAOpwQ6pCLvMprIzpuh8EbyyzrPLXPbD
         DU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768973634; x=1769578434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3UPoz+4dGK8MYLy8d1alrE5wWkl0RR3HxeTS6m1CsA=;
        b=BGC5C6Lp0NzK4hNutRa/EUmABOqZlUOY1CHNgHSb7xFbj6HbE1UDyNkZuwpj0JgUjF
         023OFHeL2jUB3zCU3mPguQ7IjoUyOeC2evJ2xz1oXDSvWkgpXvCbLWvMxhMQ80Qg06UX
         Pi+u/X9rU16eHmT1Uh4hRMnZ1VPmNj9sMupu/0RYkM2c02tSmmV6f0DaIIyZQfe/QWc7
         xK35fqa1TWO3nKi3rJX4fURYb5Bhcp2BQ5Pxk+3z+J5dzwtw9wM/OU/IrII5cznLMYvM
         JJDqND0p6SBhQWmhN7g8sDGyKba51IxMuquKFOtGqS+g618dHDZRQt+AoatgC+a/j2gY
         hhqg==
X-Forwarded-Encrypted: i=1; AJvYcCUzXjG7BAlszS7+BdZPJZBw8UXJ8vILXJMJnlRz3VIsF8khe7i6TOPGhRemUgmW4OT9Mw7pl9bOB1xB@vger.kernel.org
X-Gm-Message-State: AOJu0YywO56y2npatFsOzQC/OmjgvzhQPEfu4oUwcZ56xZZc6KBKNgCE
	8whuVjpTVoQJBwYcoGhng8QZgOZybnTE3ObWCh/g38I+DTTrYPCyDE37
X-Gm-Gg: AZuq6aKsRrpvJbpcbTWmhQfmGJchwTPwluxTNDcOSAqRaZUpRZzi3sddtNgQ2eevJcH
	h8VA95ZnPMwqnMZJPv5471VFIHJJiFiE57ubqCqMnLaWxhMeT4MDIy4QtcBQsbKW+3U9QVe2VPC
	MSE7QK1m5nFwFWQnioYFyQNn/Ft0y+9MaXoZ5Kq+ROPyxqoj5xxjNm/+Gtteb5DpUo+B39yfIMQ
	Yau8c9Q+fMopMYyAMQIrY/wv9coXYwrBX1y1i1Ifbib/KO+HWtf+LpR2aIrQqpDsUkRl5GISvll
	Zpo2meIxpd7oN9EYF5+Bl2ZZArSqGxZkp1d8i0bh3esla2lsrp3i4Y+cj94PtANJrfubyb2Fvsp
	3PgAz86FwB3tZxQ23c8DuPREXJ/BXvF/1g/X8P0hIKl/drx6iCpm+Wmtzi3MaQbowFY0dCKbzhK
	+tMfxlhwn5w4ukSPvMD5joE3INlOvemjrAsf8=
X-Received: by 2002:a05:690c:4b11:b0:787:cddb:ec2d with SMTP id 00721157ae682-7940a12058amr83337797b3.19.1768973634255;
        Tue, 20 Jan 2026 21:33:54 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170bebaesm7400355d50.21.2026.01.20.21.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:33:53 -0800 (PST)
Date: Tue, 20 Jan 2026 21:33:52 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 3/5] net: devmem: implement autorelease
 token management
Message-ID: <aXBlQJnsJ6PbqysE@devvm11784.nha0.facebook.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-3-686d0af71978@meta.com>
 <20260120170042.43f038a2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120170042.43f038a2@kernel.org>

On Tue, Jan 20, 2026 at 05:00:42PM -0800, Jakub Kicinski wrote:
> On Thu, 15 Jan 2026 21:02:14 -0800 Bobby Eshleman wrote:
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > index 596c306ce52b..a5301b150663 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -562,6 +562,17 @@ attribute-sets:
> >          type: u32
> >          checks:
> >            min: 1
> > +      -
> > +        name: autorelease
> > +        doc: |
> > +          Token autorelease mode. If true (1), leaked tokens are automatically
> > +          released when the socket closes. If false (0), leaked tokens are only
> > +          released when the dmabuf is torn down. Once a binding is created with
> > +          a specific mode, all subsequent bindings system-wide must use the
> > +          same mode.
> > +
> > +          Optional. Defaults to false if not specified.
> > +        type: u8
> 
> if you plan to have more values - u32, if not - flag
> u8 is 8b value + 24b of padding, it's only useful for proto fields
> 
> >  operations:
> >    list:
> > @@ -769,6 +780,7 @@ operations:
> >              - ifindex
> >              - fd
> >              - queues
> > +            - autorelease
> >          reply:
> >            attributes:
> >              - id
> 
> >  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
> > +static DEFINE_MUTEX(devmem_ar_lock);
> > +DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
> > +EXPORT_SYMBOL(tcp_devmem_ar_key);
> 
> I don't think you need the export, perhaps move the helper in here in
> the first place (while keeping the static inline wrapper when devmem=n)?
> 
> > +	if (autorelease)
> > +		static_branch_enable(&tcp_devmem_ar_key);
> 
> This is user-controlled (non-root), right? So I think we need 
> the deferred version of key helpers. 
> 
> > -	if (direction == DMA_TO_DEVICE) {
> > -		binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
> > -					      sizeof(struct net_iov *),
> > -					      GFP_KERNEL);
> > -		if (!binding->vec) {
> > -			err = -ENOMEM;
> > -			goto err_unmap;
> > -		}
> > +	binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
> > +				      sizeof(struct net_iov *),
> > +				      GFP_KERNEL | __GFP_ZERO);
> 
> make it a kvcalloc() while we're touching it, pls
> 
> > +	if (!binding->vec) {
> > +		err = -ENOMEM;
> > +		goto err_unmap;
> >  	}
> >  
> >  	/* For simplicity we expect to make PAGE_SIZE allocations, but the
> > @@ -306,25 +386,41 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >  			niov = &owner->area.niovs[i];
> >  			niov->type = NET_IOV_DMABUF;
> >  			niov->owner = &owner->area;
> > +			atomic_set(&niov->uref, 0);
> 
> Isn't it zero'ed during alloc?
> 
> >  			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
> >  						      net_devmem_get_dma_addr(niov));
> > -			if (direction == DMA_TO_DEVICE)
> > -				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
> > +			binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
> >  		}
> >  
> >  		virtual += len;
> >  	}
> >  
> 
> > +	if (info->attrs[NETDEV_A_DMABUF_AUTORELEASE])
> > +		autorelease =
> > +			!!nla_get_u8(info->attrs[NETDEV_A_DMABUF_AUTORELEASE]);
> 
> nla_get_u8_default() 
> 
> >  	priv = genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
> >  	if (IS_ERR(priv))
> >  		return PTR_ERR(priv);
> 
> > +static noinline_for_stack int
> > +sock_devmem_dontneed_manual_release(struct sock *sk,
> > +				    struct dmabuf_token *tokens,
> > +				    unsigned int num_tokens)
> > +{
> > +	struct net_iov *niov;
> > +	unsigned int i, j;
> > +	netmem_ref netmem;
> > +	unsigned int token;
> > +	int num_frags = 0;
> > +	int ret = 0;
> > +
> > +	if (!sk->sk_devmem_info.binding)
> > +		return -EINVAL;
> > +
> > +	for (i = 0; i < num_tokens; i++) {
> > +		for (j = 0; j < tokens[i].token_count; j++) {
> > +			size_t size = sk->sk_devmem_info.binding->dmabuf->size;
> > +
> > +			token = tokens[i].token_start + j;
> > +			if (token >= size / PAGE_SIZE)
> > +				break;
> > +
> > +			if (++num_frags > MAX_DONTNEED_FRAGS)
> > +				return ret;
> > +
> > +			niov = sk->sk_devmem_info.binding->vec[token];
> > +			if (atomic_dec_and_test(&niov->uref)) {
> 
> Don't you need something like "atomic dec non zero and test" ?
> refcount has refcount_dec_not_one() 🤔️
> 

Good point, that would be better for sure.

> > +				netmem = net_iov_to_netmem(niov);
> > +				WARN_ON_ONCE(!napi_pp_put_page(netmem));
> > +			}
> > +			ret++;
> > +		}
> 
> >  frag_limit_reached:
> > -	xa_unlock_bh(&sk->sk_user_frags);
> > +	xa_unlock_bh(&sk->sk_devmem_info.frags);
> 
> may be worth separating the sk_devmem_info change out for clarity
> 
> >  	for (k = 0; k < netmem_num; k++)
> >  		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> 
> > @@ -2503,7 +2506,15 @@ void tcp_v4_destroy_sock(struct sock *sk)
> >  
> >  	tcp_release_user_frags(sk);
> >  
> > -	xa_destroy(&sk->sk_user_frags);
> > +	if (!net_devmem_autorelease_enabled() && sk->sk_devmem_info.binding) {
> > +		net_devmem_dmabuf_binding_user_put(sk->sk_devmem_info.binding);
> > +		net_devmem_dmabuf_binding_put(sk->sk_devmem_info.binding);
> > +		sk->sk_devmem_info.binding = NULL;
> > +		WARN_ONCE(!xa_empty(&sk->sk_devmem_info.frags),
> > +			  "non-empty xarray discovered in autorelease off mode");
> > +	}
> > +
> > +	xa_destroy(&sk->sk_devmem_info.frags);
> 
> Let's wrap this up in a helper that'll live in devmem.c

All of the above SGTM!

Thanks,
Bobby
