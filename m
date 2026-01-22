Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87C4418CB
	for <linux-arch@vger.kernel.org>; Thu, 22 Jan 2026 04:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769055344; cv=pass; b=oikIrOae6N94S5xmgT8bB/3NyWHIB8JAmk3Hyu+5lXRnpzTzuaCFLDWO2ZHe/EE1iXNowbM5G+LIpbVIp6RBbchjEpET29qezDgNe/gvLlVgxpOmJ94FLXvq1HwIlKblNo8fQ8ibX2jzfRqJbUZg4mPmtA+y3WOFN2IYgegL+2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769055344; c=relaxed/simple;
	bh=0r2TOvmc/Fvl36Kc3nOoEGr8INmEDe6FLJ/NffJoR/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/VWjrfClpdmGvJ3E4cVyyNEG4D2ufqLqJTCR+QHbhGq6qjWjmYgxZFTEOPnqpIi1u0B+gmjfTvPgBa0+pr26VNnjCiPPL2oF74o8RpGlzI7GUsS3tsIpYqx1C9SMmOZoa3HiY4Q2VPQS/LN6kI/VXriVYuSFQFtRHEbFgT387I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nrbFYWHk; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nrbFYWHk"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59b30269328so1820e87.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 20:15:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769055337; cv=none;
        d=google.com; s=arc-20240605;
        b=H6Byg8Lng/StW7+YFRLUkl5xIoNOZMKHG/zxGi4/KNKOA52dxSWZgM072jZNQ/i+8Q
         WEvgWs21GweUE6G6GD3KpnMsRjKzvxG/mCf+tuJ4hDV6Qdg397sCxMWg4zmlyA+8TtLU
         eErUwmnbfMx82SIbJzoqGmqWkZBUNrW6BF/AsvWU3DwGdsNe/hM6DfRj0hmKshTdd6/r
         zqc5Gibknl7x4OOxtNujtJGzvGycz8x8ZwdYaiUi1Ii0nyDXzglvUfPPtKtDJZK82pQk
         Dbiozw71vM8Ncd06HLL9psfZ5Oz7ouHXD9O0qZivFTTydRQjtJffXGhhbxlU/gGn4J/f
         KbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6PcHUk/X4qQp2e9OokZlXF5cyHGL5uy1Nc8sVb8V6sY=;
        fh=ZGxTke7x8UgkZ6PLvEDD9dmUBFA0I4O1/L38PxK31rM=;
        b=HgHvrkmtJvdi7Adgeu60yuThQOTowvGD2RMNUJrTnwZXp0edL/JY9Rqt6Jl+joHYBU
         OHZIbY6LKTwLay6pN5vNM0szCOPfNP8FYKjChq3vRVrDY3CNDxpypX0zlYESk2FMCL17
         N7lXSqWOLp9uw3I5+KDQKUHxszQuMqORxapLkGXjSo2AZ5j6P1EG8lKb4x4FK5Mn5b9M
         VNZA4frttGVHgtgYmvJ7H46xp3R6gk/lfNwn3GXL0CtiJ/iQL31FiXOG9TsOnXR62oWs
         w1oTnNywgmWFRePYGWZLqJmzdbTUH/cUYCCXeGw2PCCDqIvZmz8UvevuwHYbEmAYDuZy
         6lBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769055337; x=1769660137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PcHUk/X4qQp2e9OokZlXF5cyHGL5uy1Nc8sVb8V6sY=;
        b=nrbFYWHkjrxhtFjES5GH8InFLFFwCmnrR+LaU1JqW1nKasl3cP6raxVLCt9QLeQEcv
         mWjG7uGtJxcK6b0LxKf4jqwdKkrtROdrtQHmtkqxqiiQRew0gaTgV4RfTe23g7G417qf
         hckh2tMXwiqFxN/v4986DQZLZKeKM6E3SmYpEW97JlJa1EqliCk0VVDWpFZULUNPjfAY
         6wGQx7rOta/hoM97pHBL2hRBJhJKEIoTRsAfi8Zrk5Bp4+eudGyWe6rreuQkch1OQNTX
         8rU6VND21hHebJbDAw3eSUwZIH/wJms3WD3Sf4Euu7/kIgJGqoKtRG/W6/bx1WcRhJ4e
         NTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769055337; x=1769660137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6PcHUk/X4qQp2e9OokZlXF5cyHGL5uy1Nc8sVb8V6sY=;
        b=kHXL34H4A6wWVC9syKIGgxTbab8TjHLbs5kOaDY6kjtaHyNDPPQoYa5v6K3EQ2YUnV
         tMxB8uEpL1KLYF0rNgD0ETQNXfYgPsYSFb3RthXx2ClTy2iKYOj40hmmsEWiVvL9ZFqi
         Gvhj9eEaqBNYjaCcIf6osk3EdkLw3FpRMWxi/Z075cj4aEZ5zI4QFI2hzHc0ZZbsRvxb
         XhWJtCPxhw5oRwIqPvngc9qFz6T4GwUdIifOQn5eqIBhNPVQAD0vQoZuC96+c7n07HU4
         Emhe4Gl8nnmvRAulcMIfU1WheKYGL0b+rua9iluGOb7EP69JOR6xgQF1pa5Eb+N8WvJQ
         siOg==
X-Forwarded-Encrypted: i=1; AJvYcCU7cJPIMmfxBMaiMjv72PrD/6vDbNM7gZ67DqxsBC+vmlwouRQa52n09f7HKcyMQCTVnVXSvokV+X3s@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIbUWH6fRDuI5uDPpmgDLUHLGxrNqfDn6J8VsN9kzYz9DdcfJ
	3XLfUcNV9dQQFWwzMXryfCbwEjahWD6cZPIasNcIvfnuM/zgEBRQl2db/r40kB/uv9DFVSdRLBm
	3yI1wNYK7efPm/xUwQiLVaF2TGS8dJaSIFP4iUIR0
X-Gm-Gg: AZuq6aIHrtSCybN7g302vFgZehRPJYdg+ya5Q8pscHxNWeAuA0Xk0lojkW4t5aLgNZk
	q5MjiRMTnS4UDA9G0sLII1crfFLXrDomwhso7+X/on308DD7rKXSIaEhpNksKDi47jbqmP5478r
	m22wgIbzjRzoqRUhcTdm96+a13PV8smJlbw8Xu8jSi0wTvTcxlpvMyF0yM8RgmPUKDBV9AH3Afx
	7Wyas1/lKLe80rxjGXL6hkA4BYO+2wIvdHWyrHw01whC+y/XIBwhU9/KJMIMmpBr8AbzDrnHIeA
	SC6urw==
X-Received: by 2002:ac2:4208:0:b0:59d:d4b4:97c7 with SMTP id
 2adb3069b0e04-59dd9e0264fmr67825e87.10.1769055336063; Wed, 21 Jan 2026
 20:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-3-686d0af71978@meta.com>
In-Reply-To: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-3-686d0af71978@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 Jan 2026 20:15:23 -0800
X-Gm-Features: AZwV_QgUpRpRSUqYRndVq4uJNrARVbrZXVk_utJAb44AQiVzYnHX54y2GzXEBrc
Message-ID: <CAHS8izP+7bnYhtSMVZ-_KrxSXd=R5-7MUaV15vs98Rk2aimQVg@mail.gmail.com>
Subject: Re: [PATCH net-next v10 3/5] net: devmem: implement autorelease token management
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 9:03=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Add support for autorelease toggling of tokens using a static branch to
> control system-wide behavior. This allows applications to choose between
> two memory management modes:
>
> 1. Autorelease on: Leaked tokens are automatically released when the
>    socket closes.
>
> 2. Autorelease off: Leaked tokens are released during dmabuf unbind.
>
> The autorelease mode is requested via the NETDEV_A_DMABUF_AUTORELEASE
> attribute of the NETDEV_CMD_BIND_RX message. Having separate modes per
> binding is disallowed and is rejected by netlink. The system will be
> "locked" into the mode that the first binding is set to. It can only be
> changed again once there are zero bindings on the system.
>
> Disabling autorelease offers ~13% improvement in CPU utilization.
>
> Static branching is used to limit the system to one mode or the other.
>
> The xa_erase(&net_devmem_dmabuf_bindings, ...) call is moved into
> __net_devmem_dmabuf_binding_free(...). The result is that it becomes
> possible to switch static branches atomically with regards to xarray
> state. In the time window between unbind and free the socket layer can
> still find the binding in the xarray, but it will fail to acquire
> binding->ref (if unbind decremented to zero). This change preserves
> correct behavior and allows us to avoid more complicated counting
> schemes for bindings.
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v10:
> - add binding->users to track socket and rxq users of binding, defer
>   release of urefs until binding->users hits zero to guard users from
>   incrementing urefs *after* net_devmem_dmabuf_binding_put_urefs()
>   is called. (Mina)
> - fix error failing to restore static key state when xarray alloc fails
>   (Jakub)
> - add wrappers for setting/unsetting mode that captures the static key +
>   rx binding count logic.
> - move xa_erase() into __net_devmem_dmabuf_binding_free()
> - remove net_devmem_rx_bindings_count, change xarray management to be
>   to avoid the same race as net_devmem_rx_bindings_count did
> - check return of net_devmem_dmabuf_binding_get() in
>   tcp_recvmsg_dmabuf()
> - move sk_devmem_info.binding fiddling into autorelease=3Doff static path
>
> Changes in v9:
> - Add missing stub for net_devmem_dmabuf_binding_get() when NET_DEVMEM=3D=
n
> - Add wrapper around tcp_devmem_ar_key accesses so that it may be
>   stubbed out when NET_DEVMEM=3Dn
> - only dec rx binding count for rx bindings in free (v8 did not exclude
>   TX bindings)
>
> Changes in v8:
> - Only reset static key when bindings go to zero, defaulting back to
>   disabled (Stan).
> - Fix bad usage of xarray spinlock for sleepy static branch switching,
>   use mutex instead.
> - Access pp_ref_count via niov->desc instead of niov directly.
> - Move reset of static key to __net_devmem_dmabuf_binding_free() so that
>   the static key can not be changed while there are outstanding tokens
>   (free is only called when reference count reaches zero).
> - Add net_devmem_dmabuf_rx_bindings_count because tokens may be active
>   even after xa_erase(), so static key changes must wait until all
>   RX bindings are finally freed (not just when xarray is empty). A
>   counter is a simple way to track this.
> - socket takes reference on the binding, to avoid use-after-free on
>   sk_devmem_info.binding in the case that user releases all tokens,
>   unbinds, then issues SO_DEVMEM_DONTNEED again (with bad token).
> - removed some comments that were unnecessary
>
> Changes in v7:
> - implement autorelease with static branch (Stan)
> - use netlink instead of sockopt (Stan)
> - merge uAPI and implementation patches into one patch (seemed less
>   confusing)
>
> Changes in v6:
> - remove sk_devmem_info.autorelease, using binding->autorelease instead
> - move binding->autorelease check to outside of
>   net_devmem_dmabuf_binding_put_urefs() (Mina)
> - remove overly defensive net_is_devmem_iov() (Mina)
> - add comment about multiple urefs mapping to a single netmem ref (Mina)
> - remove overly defense netmem NULL and netmem_is_net_iov checks (Mina)
> - use niov without casting back and forth with netmem (Mina)
> - move the autorelease flag from per-binding to per-socket (Mina)
> - remove the batching logic in sock_devmem_dontneed_manual_release()
>   (Mina)
> - move autorelease check inside tcp_xa_pool_commit() (Mina)
> - remove single-binding restriction for autorelease mode (Mina)
> - unbind always checks for leaked urefs
>
> Changes in v5:
> - remove unused variables
> - introduce autorelease flag, preparing for future patch toggle new
>   behavior
>
> Changes in v3:
> - make urefs per-binding instead of per-socket, reducing memory
>   footprint
> - fallback to cleaning up references in dmabuf unbind if socket leaked
>   tokens
> - drop ethtool patch
>
> Changes in v2:
> - always use GFP_ZERO for binding->vec (Mina)
> - remove WARN for changed binding (Mina)
> - remove extraneous binding ref get (Mina)
> - remove WARNs on invalid user input (Mina)
> - pre-assign niovs in binding->vec for RX case (Mina)
> - use atomic_set(, 0) to initialize sk_user_frags.urefs
> - fix length of alloc for urefs
> ---
>  Documentation/netlink/specs/netdev.yaml |  12 +++
>  include/net/netmem.h                    |   1 +
>  include/net/sock.h                      |   7 +-
>  include/uapi/linux/netdev.h             |   1 +
>  net/core/devmem.c                       | 136 ++++++++++++++++++++++++++=
+-----
>  net/core/devmem.h                       |  64 ++++++++++++++-
>  net/core/netdev-genl-gen.c              |   5 +-
>  net/core/netdev-genl.c                  |  10 ++-
>  net/core/sock.c                         |  57 +++++++++++--
>  net/ipv4/tcp.c                          |  87 ++++++++++++++++----
>  net/ipv4/tcp_ipv4.c                     |  15 +++-
>  net/ipv4/tcp_minisocks.c                |   3 +-
>  tools/include/uapi/linux/netdev.h       |   1 +
>  13 files changed, 345 insertions(+), 54 deletions(-)
>
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

Ooof. Defaults to false if not specified.

My anxiety with this patch is that running an actual ML training job
involves many layers of middleware where we may not be able to enforce
the "must don'tneeding before closing the socket" requirement. I'm
curious if you have ML jobs or NCCL tests running on this and passing?

> +        type: u8
>
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
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 9e10f4ac50c3..80d2263ba4ed 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -112,6 +112,7 @@ struct net_iov {
>         };
>         struct net_iov_area *owner;
>         enum net_iov_type type;
> +       atomic_t uref;
>  };
>
>  struct net_iov_area {
> diff --git a/include/net/sock.h b/include/net/sock.h
> index aafe8bdb2c0f..9d3d5bde15e9 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -352,7 +352,7 @@ struct sk_filter;
>    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
>    *    @sk_scm_unused: unused flags for scm_recv()
>    *    @ns_tracker: tracker for netns reference
> -  *    @sk_user_frags: xarray of pages the user is holding a reference o=
n.
> +  *    @sk_devmem_info: the devmem binding information for the socket
>    *    @sk_owner: reference to the real owner of the socket that calls
>    *               sock_lock_init_class_and_name().
>    */
> @@ -584,7 +584,10 @@ struct sock {
>         struct numa_drop_counters *sk_drop_counters;
>         struct rcu_head         sk_rcu;
>         netns_tracker           ns_tracker;
> -       struct xarray           sk_user_frags;
> +       struct {
> +               struct xarray                           frags;
> +               struct net_devmem_dmabuf_binding        *binding;
> +       } sk_devmem_info;
>
>  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
>         struct module           *sk_owner;
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index e0b579a1df4f..1e5c209cb998 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -207,6 +207,7 @@ enum {
>         NETDEV_A_DMABUF_QUEUES,
>         NETDEV_A_DMABUF_FD,
>         NETDEV_A_DMABUF_ID,
> +       NETDEV_A_DMABUF_AUTORELEASE,
>
>         __NETDEV_A_DMABUF_MAX,
>         NETDEV_A_DMABUF_MAX =3D (__NETDEV_A_DMABUF_MAX - 1)
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 9dee697a28ee..1264d8ee40e3 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -11,6 +11,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/mm.h>
>  #include <linux/netdevice.h>
> +#include <linux/skbuff_ref.h>
>  #include <linux/types.h>
>  #include <net/netdev_queues.h>
>  #include <net/netdev_rx_queue.h>
> @@ -27,6 +28,9 @@
>  /* Device memory support */
>
>  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
> +static DEFINE_MUTEX(devmem_ar_lock);
> +DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
> +EXPORT_SYMBOL(tcp_devmem_ar_key);
>
>  static const struct memory_provider_ops dmabuf_devmem_ops;
>
> @@ -63,12 +67,71 @@ static void net_devmem_dmabuf_binding_release(struct =
percpu_ref *ref)
>         schedule_work(&binding->unbind_w);
>  }
>
> +static bool net_devmem_has_rx_bindings(void)
> +{
> +       struct net_devmem_dmabuf_binding *binding;
> +       unsigned long index;
> +
> +       lockdep_assert_held(&devmem_ar_lock);
> +
> +       xa_for_each(&net_devmem_dmabuf_bindings, index, binding) {
> +               if (binding->direction =3D=3D DMA_FROM_DEVICE)
> +                       return true;
> +       }
> +       return false;
> +}
> +
> +/* caller must hold devmem_ar_lock */
> +static int
> +__net_devmem_dmabuf_binding_set_mode(enum dma_data_direction direction,
> +                                    bool autorelease)
> +{
> +       lockdep_assert_held(&devmem_ar_lock);
> +
> +       if (direction !=3D DMA_FROM_DEVICE)
> +               return 0;
> +
> +       if (net_devmem_has_rx_bindings() &&
> +           static_key_enabled(&tcp_devmem_ar_key) !=3D autorelease)
> +               return -EBUSY;
> +
> +       if (autorelease)
> +               static_branch_enable(&tcp_devmem_ar_key);
> +
> +       return 0;
> +}
> +
> +/* caller must hold devmem_ar_lock */
> +static void
> +__net_devmem_dmabuf_binding_unset_mode(enum dma_data_direction direction=
)
> +{
> +       lockdep_assert_held(&devmem_ar_lock);
> +
> +       if (direction !=3D DMA_FROM_DEVICE)
> +               return;
> +
> +       if (net_devmem_has_rx_bindings())
> +               return;
> +
> +       static_branch_disable(&tcp_devmem_ar_key);
> +}
> +
>  void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
>  {
>         struct net_devmem_dmabuf_binding *binding =3D container_of(wq, ty=
peof(*binding), unbind_w);
>
>         size_t size, avail;
>
> +       mutex_lock(&devmem_ar_lock);
> +       xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> +       __net_devmem_dmabuf_binding_unset_mode(binding->direction);
> +       mutex_unlock(&devmem_ar_lock);
> +
> +       /* Ensure no tx net_devmem_lookup_dmabuf() are in flight after th=
e
> +        * erase.
> +        */
> +       synchronize_net();
> +

I'm sorry I could not wrap my head around moving this block of code to
the _free(), even though you mention it in the commit message. Why is
removing the the binding from net_devmem_dmabuf_bindings on unbind not
work for you? If the binding is not active on any rx queues then there
cannot be new data received on it. Unless I'm missing something it
should be fine to leave this where it is.


>         gen_pool_for_each_chunk(binding->chunk_pool,
>                                 net_devmem_dmabuf_free_chunk_owner, NULL)=
;
>
> @@ -126,19 +189,30 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
>         gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
>  }
>
> +void
> +net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *bi=
nding)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < binding->dmabuf->size / PAGE_SIZE; i++) {
> +               struct net_iov *niov;
> +               netmem_ref netmem;
> +
> +               niov =3D binding->vec[i];
> +               netmem =3D net_iov_to_netmem(niov);
> +
> +               /* Multiple urefs map to only a single netmem ref. */
> +               if (atomic_xchg(&niov->uref, 0) > 0)
> +                       WARN_ON_ONCE(!napi_pp_put_page(netmem));
> +       }
> +}
> +
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  {
>         struct netdev_rx_queue *rxq;
>         unsigned long xa_idx;
>         unsigned int rxq_idx;
>
> -       xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> -
> -       /* Ensure no tx net_devmem_lookup_dmabuf() are in flight after th=
e
> -        * erase.
> -        */
> -       synchronize_net();
> -
>         if (binding->list.next)
>                 list_del(&binding->list);
>
> @@ -151,6 +225,8 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabu=
f_binding *binding)
>                 rxq_idx =3D get_netdev_rx_queue_index(rxq);
>
>                 __net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
> +
> +               net_devmem_dmabuf_binding_user_put(binding);
>         }
>
>         percpu_ref_kill(&binding->ref);
> @@ -178,6 +254,8 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device=
 *dev, u32 rxq_idx,
>         if (err)
>                 goto err_close_rxq;
>
> +       atomic_inc(&binding->users);
> +

nit: feels wrong that we have _binding_user_put() but open code the
get(). Either open code both or helper both, maybe?

>         return 0;
>
>  err_close_rxq:
> @@ -189,8 +267,10 @@ struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev,
>                        struct device *dma_dev,
>                        enum dma_data_direction direction,
> -                      unsigned int dmabuf_fd, struct netdev_nl_sock *pri=
v,
> -                      struct netlink_ext_ack *extack)
> +                      unsigned int dmabuf_fd,
> +                      struct netdev_nl_sock *priv,
> +                      struct netlink_ext_ack *extack,
> +                      bool autorelease)
>  {
>         struct net_devmem_dmabuf_binding *binding;
>         static u32 id_alloc_next;
> @@ -225,6 +305,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>         if (err < 0)
>                 goto err_free_binding;
>
> +       atomic_set(&binding->users, 0);
> +
>         mutex_init(&binding->lock);
>
>         binding->dmabuf =3D dmabuf;
> @@ -245,14 +327,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                 goto err_detach;
>         }
>
> -       if (direction =3D=3D DMA_TO_DEVICE) {
> -               binding->vec =3D kvmalloc_array(dmabuf->size / PAGE_SIZE,
> -                                             sizeof(struct net_iov *),
> -                                             GFP_KERNEL);
> -               if (!binding->vec) {
> -                       err =3D -ENOMEM;
> -                       goto err_unmap;
> -               }
> +       binding->vec =3D kvmalloc_array(dmabuf->size / PAGE_SIZE,
> +                                     sizeof(struct net_iov *),
> +                                     GFP_KERNEL | __GFP_ZERO);
> +       if (!binding->vec) {
> +               err =3D -ENOMEM;
> +               goto err_unmap;
>         }
>
>         /* For simplicity we expect to make PAGE_SIZE allocations, but th=
e
> @@ -306,25 +386,41 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                         niov =3D &owner->area.niovs[i];
>                         niov->type =3D NET_IOV_DMABUF;
>                         niov->owner =3D &owner->area;
> +                       atomic_set(&niov->uref, 0);
>                         page_pool_set_dma_addr_netmem(net_iov_to_netmem(n=
iov),
>                                                       net_devmem_get_dma_=
addr(niov));
> -                       if (direction =3D=3D DMA_TO_DEVICE)
> -                               binding->vec[owner->area.base_virtual / P=
AGE_SIZE + i] =3D niov;
> +                       binding->vec[owner->area.base_virtual / PAGE_SIZE=
 + i] =3D niov;
>                 }
>
>                 virtual +=3D len;
>         }
>
> +       mutex_lock(&devmem_ar_lock);
> +
> +       err =3D __net_devmem_dmabuf_binding_set_mode(direction, autorelea=
se);
> +       if (err < 0) {
> +               NL_SET_ERR_MSG_FMT(extack,
> +                                  "System already configured with autore=
lease=3D%d",
> +                                  static_key_enabled(&tcp_devmem_ar_key)=
);
> +               goto err_unlock_mutex;
> +       }
> +

Unless I've misread something, this looks very incorrect. TX bindings
will accidentally set the system to autorelease=3Dfalse mode, no? You
need to make sure you only set the mode in rx-bindings only, right?

>         err =3D xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id=
,
>                               binding, xa_limit_32b, &id_alloc_next,
>                               GFP_KERNEL);
>         if (err < 0)
> -               goto err_free_chunks;
> +               goto err_unset_mode;
> +
> +       mutex_unlock(&devmem_ar_lock);
>
>         list_add(&binding->list, &priv->bindings);
>
>         return binding;
>
> +err_unset_mode:
> +       __net_devmem_dmabuf_binding_unset_mode(direction);
> +err_unlock_mutex:
> +       mutex_unlock(&devmem_ar_lock);
>  err_free_chunks:
>         gen_pool_for_each_chunk(binding->chunk_pool,
>                                 net_devmem_dmabuf_free_chunk_owner, NULL)=
;
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 94874b323520..284f0ad5f381 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -12,9 +12,13 @@
>
>  #include <net/netmem.h>
>  #include <net/netdev_netlink.h>
> +#include <linux/jump_label.h>
>
>  struct netlink_ext_ack;
>
> +/* static key for TCP devmem autorelease */
> +extern struct static_key_false tcp_devmem_ar_key;
> +
>  struct net_devmem_dmabuf_binding {
>         struct dma_buf *dmabuf;
>         struct dma_buf_attachment *attachment;
> @@ -43,6 +47,12 @@ struct net_devmem_dmabuf_binding {
>          */
>         struct percpu_ref ref;
>
> +       /* Counts sockets and rxqs that are using the binding. When this
> +        * reaches zero, all urefs are drained and new sockets cannot joi=
n the
> +        * binding.
> +        */
> +       atomic_t users;
> +
>         /* The list of bindings currently active. Used for netlink to not=
ify us
>          * of the user dropping the bind.
>          */
> @@ -61,7 +71,7 @@ struct net_devmem_dmabuf_binding {
>
>         /* Array of net_iov pointers for this binding, sorted by virtual
>          * address. This array is convenient to map the virtual addresses=
 to
> -        * net_iovs in the TX path.
> +        * net_iovs.
>          */
>         struct net_iov **vec;
>
> @@ -88,7 +98,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                        struct device *dma_dev,
>                        enum dma_data_direction direction,
>                        unsigned int dmabuf_fd, struct netdev_nl_sock *pri=
v,
> -                      struct netlink_ext_ack *extack);
> +                      struct netlink_ext_ack *extack, bool autorelease);
>  struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)=
;
>  int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> @@ -134,6 +144,26 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmab=
uf_binding *binding)
>         percpu_ref_put(&binding->ref);
>  }
>
> +void net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_bindin=
g *binding);
> +
> +static inline bool
> +net_devmem_dmabuf_binding_user_get(struct net_devmem_dmabuf_binding *bin=
ding)
> +{
> +       return atomic_inc_not_zero(&binding->users);
> +}
> +
> +static inline void
> +net_devmem_dmabuf_binding_user_put(struct net_devmem_dmabuf_binding *bin=
ding)
> +{
> +       if (atomic_dec_and_test(&binding->users))
> +               net_devmem_dmabuf_binding_put_urefs(binding);
> +}
> +
> +static inline bool net_devmem_autorelease_enabled(void)
> +{
> +       return static_branch_unlikely(&tcp_devmem_ar_key);
> +}
> +
>  void net_devmem_get_net_iov(struct net_iov *niov);
>  void net_devmem_put_net_iov(struct net_iov *niov);
>
> @@ -151,11 +181,38 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_bin=
ding *binding, size_t addr,
>  #else
>  struct net_devmem_dmabuf_binding;
>
> +static inline bool
> +net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
> +{
> +       return false;
> +}
> +
>  static inline void
>  net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
>  {
>  }
>
> +static inline void
> +net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *bi=
nding)
> +{
> +}
> +
> +static inline bool
> +net_devmem_dmabuf_binding_user_get(struct net_devmem_dmabuf_binding *bin=
ding)
> +{
> +       return false;
> +}
> +
> +static inline void
> +net_devmem_dmabuf_binding_user_put(struct net_devmem_dmabuf_binding *bin=
ding)
> +{
> +}
> +
> +static inline bool net_devmem_autorelease_enabled(void)
> +{
> +       return false;
> +}
> +
>  static inline void net_devmem_get_net_iov(struct net_iov *niov)
>  {
>  }
> @@ -170,7 +227,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                        enum dma_data_direction direction,
>                        unsigned int dmabuf_fd,
>                        struct netdev_nl_sock *priv,
> -                      struct netlink_ext_ack *extack)
> +                      struct netlink_ext_ack *extack,
> +                      bool autorelease)
>  {
>         return ERR_PTR(-EOPNOTSUPP);
>  }
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index ba673e81716f..01b7765e11ec 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -86,10 +86,11 @@ static const struct nla_policy netdev_qstats_get_nl_p=
olicy[NETDEV_A_QSTATS_SCOPE
>  };
>
>  /* NETDEV_CMD_BIND_RX - do */
> -static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_=
FD + 1] =3D {
> +static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_=
AUTORELEASE + 1] =3D {
>         [NETDEV_A_DMABUF_IFINDEX] =3D NLA_POLICY_MIN(NLA_U32, 1),
>         [NETDEV_A_DMABUF_FD] =3D { .type =3D NLA_U32, },
>         [NETDEV_A_DMABUF_QUEUES] =3D NLA_POLICY_NESTED(netdev_queue_id_nl=
_policy),
> +       [NETDEV_A_DMABUF_AUTORELEASE] =3D { .type =3D NLA_U8, },

This patch in the series is proving complicated to review. Any changes
you can refactor out of it for ease of review would be very welcome.
Things like the variable renames, netlink api changes, and any
refactors can be pulled into their own patches would ease review of
the core functionality.

>  };
>
>  /* NETDEV_CMD_NAPI_SET - do */
> @@ -188,7 +189,7 @@ static const struct genl_split_ops netdev_nl_ops[] =
=3D {
>                 .cmd            =3D NETDEV_CMD_BIND_RX,
>                 .doit           =3D netdev_nl_bind_rx_doit,
>                 .policy         =3D netdev_bind_rx_nl_policy,
> -               .maxattr        =3D NETDEV_A_DMABUF_FD,
> +               .maxattr        =3D NETDEV_A_DMABUF_AUTORELEASE,
>                 .flags          =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>         },
>         {
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 470fabbeacd9..c742bb34865e 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -939,6 +939,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struc=
t genl_info *info)
>         struct netdev_nl_sock *priv;
>         struct net_device *netdev;
>         unsigned long *rxq_bitmap;
> +       bool autorelease =3D false;
>         struct device *dma_dev;
>         struct sk_buff *rsp;
>         int err =3D 0;
> @@ -952,6 +953,10 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, stru=
ct genl_info *info)
>         ifindex =3D nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
>         dmabuf_fd =3D nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
>
> +       if (info->attrs[NETDEV_A_DMABUF_AUTORELEASE])
> +               autorelease =3D
> +                       !!nla_get_u8(info->attrs[NETDEV_A_DMABUF_AUTORELE=
ASE]);
> +
>         priv =3D genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
>         if (IS_ERR(priv))
>                 return PTR_ERR(priv);
> @@ -1002,7 +1007,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, str=
uct genl_info *info)
>         }
>
>         binding =3D net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVI=
CE,
> -                                        dmabuf_fd, priv, info->extack);
> +                                        dmabuf_fd, priv, info->extack,
> +                                        autorelease);
>         if (IS_ERR(binding)) {
>                 err =3D PTR_ERR(binding);
>                 goto err_rxq_bitmap;
> @@ -1097,7 +1103,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, str=
uct genl_info *info)
>
>         dma_dev =3D netdev_queue_get_dma_dev(netdev, 0);
>         binding =3D net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE=
,
> -                                        dmabuf_fd, priv, info->extack);
> +                                        dmabuf_fd, priv, info->extack, f=
alse);
>         if (IS_ERR(binding)) {
>                 err =3D PTR_ERR(binding);
>                 goto err_unlock_netdev;
> diff --git a/net/core/sock.c b/net/core/sock.c
> index f6526f43aa6e..6355c2ccfb8a 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -87,6 +87,7 @@
>
>  #include <linux/unaligned.h>
>  #include <linux/capability.h>
> +#include <linux/dma-buf.h>
>  #include <linux/errno.h>
>  #include <linux/errqueue.h>
>  #include <linux/types.h>
> @@ -151,6 +152,7 @@
>  #include <uapi/linux/pidfd.h>
>
>  #include "dev.h"
> +#include "devmem.h"
>
>  static DEFINE_MUTEX(proto_list_mutex);
>  static LIST_HEAD(proto_list);
> @@ -1081,6 +1083,44 @@ static int sock_reserve_memory(struct sock *sk, in=
t bytes)
>  #define MAX_DONTNEED_TOKENS 128
>  #define MAX_DONTNEED_FRAGS 1024
>
> +static noinline_for_stack int
> +sock_devmem_dontneed_manual_release(struct sock *sk,
> +                                   struct dmabuf_token *tokens,
> +                                   unsigned int num_tokens)
> +{
> +       struct net_iov *niov;
> +       unsigned int i, j;
> +       netmem_ref netmem;
> +       unsigned int token;
> +       int num_frags =3D 0;
> +       int ret =3D 0;
> +
> +       if (!sk->sk_devmem_info.binding)
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < num_tokens; i++) {
> +               for (j =3D 0; j < tokens[i].token_count; j++) {
> +                       size_t size =3D sk->sk_devmem_info.binding->dmabu=
f->size;
> +
> +                       token =3D tokens[i].token_start + j;
> +                       if (token >=3D size / PAGE_SIZE)
> +                               break;
> +
> +                       if (++num_frags > MAX_DONTNEED_FRAGS)
> +                               return ret;
> +
> +                       niov =3D sk->sk_devmem_info.binding->vec[token];
> +                       if (atomic_dec_and_test(&niov->uref)) {
> +                               netmem =3D net_iov_to_netmem(niov);
> +                               WARN_ON_ONCE(!napi_pp_put_page(netmem));
> +                       }
> +                       ret++;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
>  static noinline_for_stack int
>  sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *t=
okens,
>                                  unsigned int num_tokens)
> @@ -1089,32 +1129,33 @@ sock_devmem_dontneed_autorelease(struct sock *sk,=
 struct dmabuf_token *tokens,
>         int ret =3D 0, num_frags =3D 0;
>         netmem_ref netmems[16];
>
> -       xa_lock_bh(&sk->sk_user_frags);
> +       xa_lock_bh(&sk->sk_devmem_info.frags);
>         for (i =3D 0; i < num_tokens; i++) {
>                 for (j =3D 0; j < tokens[i].token_count; j++) {
>                         if (++num_frags > MAX_DONTNEED_FRAGS)
>                                 goto frag_limit_reached;
>
>                         netmem_ref netmem =3D (__force netmem_ref)__xa_er=
ase(
> -                               &sk->sk_user_frags, tokens[i].token_start=
 + j);
> +                               &sk->sk_devmem_info.frags,
> +                               tokens[i].token_start + j);
>
>                         if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(ne=
tmem)))
>                                 continue;
>
>                         netmems[netmem_num++] =3D netmem;
>                         if (netmem_num =3D=3D ARRAY_SIZE(netmems)) {
> -                               xa_unlock_bh(&sk->sk_user_frags);
> +                               xa_unlock_bh(&sk->sk_devmem_info.frags);
>                                 for (k =3D 0; k < netmem_num; k++)
>                                         WARN_ON_ONCE(!napi_pp_put_page(ne=
tmems[k]));
>                                 netmem_num =3D 0;
> -                               xa_lock_bh(&sk->sk_user_frags);
> +                               xa_lock_bh(&sk->sk_devmem_info.frags);
>                         }
>                         ret++;
>                 }
>         }
>
>  frag_limit_reached:
> -       xa_unlock_bh(&sk->sk_user_frags);
> +       xa_unlock_bh(&sk->sk_devmem_info.frags);
>         for (k =3D 0; k < netmem_num; k++)
>                 WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
>
> @@ -1145,7 +1186,11 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t op=
tval, unsigned int optlen)
>                 return -EFAULT;
>         }
>
> -       ret =3D sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
> +       if (net_devmem_autorelease_enabled())
> +               ret =3D sock_devmem_dontneed_autorelease(sk, tokens, num_=
tokens);
> +       else
> +               ret =3D sock_devmem_dontneed_manual_release(sk, tokens,
> +                                                         num_tokens);
>
>         kvfree(tokens);
>         return ret;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index d5319ebe2452..73a577bd8765 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -260,6 +260,7 @@
>  #include <linux/memblock.h>
>  #include <linux/highmem.h>
>  #include <linux/cache.h>
> +#include <linux/dma-buf.h>
>  #include <linux/err.h>
>  #include <linux/time.h>
>  #include <linux/slab.h>
> @@ -492,7 +493,8 @@ void tcp_init_sock(struct sock *sk)
>
>         set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>         sk_sockets_allocated_inc(sk);
> -       xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
> +       xa_init_flags(&sk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
> +       sk->sk_devmem_info.binding =3D NULL;
>  }
>  EXPORT_IPV6_MOD(tcp_init_sock);
>
> @@ -2424,11 +2426,12 @@ static void tcp_xa_pool_commit_locked(struct sock=
 *sk, struct tcp_xa_pool *p)
>
>         /* Commit part that has been copied to user space. */
>         for (i =3D 0; i < p->idx; i++)
> -               __xa_cmpxchg(&sk->sk_user_frags, p->tokens[i], XA_ZERO_EN=
TRY,
> -                            (__force void *)p->netmems[i], GFP_KERNEL);
> +               __xa_cmpxchg(&sk->sk_devmem_info.frags, p->tokens[i],
> +                            XA_ZERO_ENTRY, (__force void *)p->netmems[i]=
,
> +                            GFP_KERNEL);
>         /* Rollback what has been pre-allocated and is no longer needed. =
*/
>         for (; i < p->max; i++)
> -               __xa_erase(&sk->sk_user_frags, p->tokens[i]);
> +               __xa_erase(&sk->sk_devmem_info.frags, p->tokens[i]);
>
>         p->max =3D 0;
>         p->idx =3D 0;
> @@ -2436,14 +2439,17 @@ static void tcp_xa_pool_commit_locked(struct sock=
 *sk, struct tcp_xa_pool *p)
>
>  static void tcp_xa_pool_commit(struct sock *sk, struct tcp_xa_pool *p)
>  {
> +       if (!net_devmem_autorelease_enabled())
> +               return;
> +
>         if (!p->max)
>                 return;
>
> -       xa_lock_bh(&sk->sk_user_frags);
> +       xa_lock_bh(&sk->sk_devmem_info.frags);
>
>         tcp_xa_pool_commit_locked(sk, p);
>
> -       xa_unlock_bh(&sk->sk_user_frags);
> +       xa_unlock_bh(&sk->sk_devmem_info.frags);
>  }
>
>  static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
> @@ -2454,24 +2460,41 @@ static int tcp_xa_pool_refill(struct sock *sk, st=
ruct tcp_xa_pool *p,
>         if (p->idx < p->max)
>                 return 0;
>
> -       xa_lock_bh(&sk->sk_user_frags);
> +       xa_lock_bh(&sk->sk_devmem_info.frags);
>
>         tcp_xa_pool_commit_locked(sk, p);
>
>         for (k =3D 0; k < max_frags; k++) {
> -               err =3D __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
> +               err =3D __xa_alloc(&sk->sk_devmem_info.frags, &p->tokens[=
k],
>                                  XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL)=
;
>                 if (err)
>                         break;
>         }
>
> -       xa_unlock_bh(&sk->sk_user_frags);
> +       xa_unlock_bh(&sk->sk_devmem_info.frags);
>
>         p->max =3D k;
>         p->idx =3D 0;
>         return k ? 0 : err;
>  }
>
> +static void tcp_xa_pool_inc_pp_ref_count(struct tcp_xa_pool *tcp_xa_pool=
,
> +                                        skb_frag_t *frag)
> +{
> +       struct net_iov *niov;
> +
> +       niov =3D skb_frag_net_iov(frag);
> +
> +       if (net_devmem_autorelease_enabled()) {
> +               atomic_long_inc(&niov->desc.pp_ref_count);
> +               tcp_xa_pool->netmems[tcp_xa_pool->idx++] =3D
> +                       skb_frag_netmem(frag);
> +       } else {
> +               if (atomic_inc_return(&niov->uref) =3D=3D 1)
> +                       atomic_long_inc(&niov->desc.pp_ref_count);
> +       }
> +}
> +
>  /* On error, returns the -errno. On success, returns number of bytes sen=
t to the
>   * user. May not consume all of @remaining_len.
>   */
> @@ -2533,6 +2556,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, cons=
t struct sk_buff *skb,
>                  * sequence of cmsg
>                  */
>                 for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> +                       struct net_devmem_dmabuf_binding *binding =3D NUL=
L;
>                         skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
>                         struct net_iov *niov;
>                         u64 frag_offset;
> @@ -2568,13 +2592,45 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, co=
nst struct sk_buff *skb,
>                                               start;
>                                 dmabuf_cmsg.frag_offset =3D frag_offset;
>                                 dmabuf_cmsg.frag_size =3D copy;
> -                               err =3D tcp_xa_pool_refill(sk, &tcp_xa_po=
ol,
> -                                                        skb_shinfo(skb)-=
>nr_frags - i);
> -                               if (err)
> -                                       goto out;
> +
> +                               binding =3D net_devmem_iov_binding(niov);
> +
> +                               if (net_devmem_autorelease_enabled()) {
> +                                       err =3D tcp_xa_pool_refill(sk,
> +                                                                &tcp_xa_=
pool,
> +                                                                skb_shin=
fo(skb)->nr_frags - i);
> +                                       if (err)
> +                                               goto out;
> +
> +                                       dmabuf_cmsg.frag_token =3D
> +                                               tcp_xa_pool.tokens[tcp_xa=
_pool.idx];
> +                               } else {
> +                                       if (!sk->sk_devmem_info.binding) =
{
> +                                               if (!net_devmem_dmabuf_bi=
nding_user_get(binding)) {
> +                                                       err =3D -ENODEV;
> +                                                       goto out;
> +                                               }
> +
> +                                               if (!net_devmem_dmabuf_bi=
nding_get(binding)) {
> +                                                       net_devmem_dmabuf=
_binding_user_put(binding);
> +                                                       err =3D -ENODEV;
> +                                                       goto out;
> +                                               }
> +
> +                                               sk->sk_devmem_info.bindin=
g =3D binding;
> +                                       }
> +
> +                                       if (sk->sk_devmem_info.binding !=
=3D binding) {
> +                                               err =3D -EFAULT;
> +                                               goto out;
> +                                       }
> +
> +                                       dmabuf_cmsg.frag_token =3D
> +                                               net_iov_virtual_addr(niov=
) >> PAGE_SHIFT;
> +                               }
> +
>
>                                 /* Will perform the exchange later */
> -                               dmabuf_cmsg.frag_token =3D tcp_xa_pool.to=
kens[tcp_xa_pool.idx];
>                                 dmabuf_cmsg.dmabuf_id =3D net_devmem_iov_=
binding_id(niov);
>
>                                 offset +=3D copy;
> @@ -2587,8 +2643,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, cons=
t struct sk_buff *skb,
>                                 if (err)
>                                         goto out;
>
> -                               atomic_long_inc(&niov->desc.pp_ref_count)=
;
> -                               tcp_xa_pool.netmems[tcp_xa_pool.idx++] =
=3D skb_frag_netmem(frag);
> +                               tcp_xa_pool_inc_pp_ref_count(&tcp_xa_pool=
, frag);
>
>                                 sent +=3D copy;
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index f8a9596e8f4d..420e8c8ebf6d 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -89,6 +89,9 @@
>
>  #include <crypto/md5.h>
>
> +#include <linux/dma-buf.h>
> +#include "../core/devmem.h"
> +
>  #include <trace/events/tcp.h>
>
>  #ifdef CONFIG_TCP_MD5SIG
> @@ -2492,7 +2495,7 @@ static void tcp_release_user_frags(struct sock *sk)
>         unsigned long index;
>         void *netmem;
>
> -       xa_for_each(&sk->sk_user_frags, index, netmem)
> +       xa_for_each(&sk->sk_devmem_info.frags, index, netmem)
>                 WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem=
));
>  #endif
>  }
> @@ -2503,7 +2506,15 @@ void tcp_v4_destroy_sock(struct sock *sk)
>
>         tcp_release_user_frags(sk);
>
> -       xa_destroy(&sk->sk_user_frags);
> +       if (!net_devmem_autorelease_enabled() && sk->sk_devmem_info.bindi=
ng) {
> +               net_devmem_dmabuf_binding_user_put(sk->sk_devmem_info.bin=
ding);
> +               net_devmem_dmabuf_binding_put(sk->sk_devmem_info.binding)=
;
> +               sk->sk_devmem_info.binding =3D NULL;
> +               WARN_ONCE(!xa_empty(&sk->sk_devmem_info.frags),
> +                         "non-empty xarray discovered in autorelease off=
 mode");
> +       }
> +
> +       xa_destroy(&sk->sk_devmem_info.frags);
>
>         trace_tcp_destroy_sock(sk);
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index bd5462154f97..2aec977f5c12 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -662,7 +662,8 @@ struct sock *tcp_create_openreq_child(const struct so=
ck *sk,
>
>         __TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
>
> -       xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
> +       xa_init_flags(&newsk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
> +       newsk->sk_devmem_info.binding =3D NULL;
>
>         return newsk;
>  }
> diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux=
/netdev.h
> index e0b579a1df4f..1e5c209cb998 100644
> --- a/tools/include/uapi/linux/netdev.h
> +++ b/tools/include/uapi/linux/netdev.h
> @@ -207,6 +207,7 @@ enum {
>         NETDEV_A_DMABUF_QUEUES,
>         NETDEV_A_DMABUF_FD,
>         NETDEV_A_DMABUF_ID,
> +       NETDEV_A_DMABUF_AUTORELEASE,
>
>         __NETDEV_A_DMABUF_MAX,
>         NETDEV_A_DMABUF_MAX =3D (__NETDEV_A_DMABUF_MAX - 1)
>
> --
> 2.47.3
>


--=20
Thanks,
Mina
