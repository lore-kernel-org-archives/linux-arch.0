Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A7B22D4C8
	for <linux-arch@vger.kernel.org>; Tue, 27 Jan 2026 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496527; cv=pass; b=vGLhJrlV0+vRsQ1J+/QECDNKrYzne5W+wJdnQtsNy5cdZYKiBdhsLHYAC5EYhX0DMlsaSdFkNMyjM6vpRMUFO9PDvr4VV1oFyDXC9AYe76v6TwLT9f72JjS4kAsjIUpbgLp05rC0PjCPvPjWzbMWVfWmqPEeLqPBkooK9dM6Q9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496527; c=relaxed/simple;
	bh=CxIRMovTnfY7BOPDwAT+IKKznYhpBl0NgKictrAZAM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRza7hcJjD0Rn9jiYHahLAuDmliuerC/A/OiRuZ3XO6TXBBPIDv1Bo8bAzc6FNlrnGpPA8y+OgD0IIscUFRKp4P/tCYbApklifUOcvA6Nn5eZMmwEExLk3hD5/pF1/HAp5GOx7ES2jq6YayJzQgBcEvlSF+kVxDDp+SN4EhZaaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nluosrmj; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nluosrmj"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d1872504cbso9890a34.0
        for <linux-arch@vger.kernel.org>; Mon, 26 Jan 2026 22:48:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769496524; cv=none;
        d=google.com; s=arc-20240605;
        b=E3v+xVP9VkzA4ksmYJIemcEMvhxu7b12hjcu4JBBgmSadVbS5ibnVNyilUf6I7PUiE
         GrrNqPypsdJ+jsEaFWI1IPUWE0C1yIknKHc7v1BATRkR4C7EK/4jIZR3gw9rGEkIYhOC
         o68029zoqxPQEmSfjuWaOmQ+9tfaKLR2EQTqkdwoNvoQxSE580/MU8BgW4tmH+B6Vu1q
         Dl6O0hutHDyjpYtMEzeNK3hlvx7OI8Hli2Sf7DImZ/BPXpS4ht9+4GN5Zjfr5r1erNYJ
         ZP0+nL3sjxjBIzNb+LmQmYoddJmmqoMqeY5W1ZgDKW0WhqczHgHPxmluJmsk9wuZoSBT
         VFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CxIRMovTnfY7BOPDwAT+IKKznYhpBl0NgKictrAZAM8=;
        fh=MPxz4IIKRL81+fWwFmdYxgUKfSBmAlPtCHuSr4zeTB4=;
        b=Qkd3fTFvJz2oJP9YagStqDmQpzDVHsllaJOoio/mUz+ujcsuY3CCf4BsFzKokFUZww
         cIhmMF9kyPDQ5HTay0Sc3X4KqQ7NTYZBmQ58KjZcTRwpUY1vbDX2A8tFFmkTo8Ww7/AS
         v266r7CkcaI8JlgnYWd9ZpU7sCvgfGvfNaNt1W0gE0q4ANjhyYmkGotw8UF6UORsXGFX
         d3LQvzPSmRBYbnj4AdmkAbtwXptQx1dIRLX4Qbov5acTUF/2e3exCh5SUE8OqAecJVzE
         aewkBMlR8NPQ/ci7MwID4j+9dZxk/VH2Rqf7BPkpl6jnHD4yIbvQud0N82tmngymtgvE
         3f7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769496524; x=1770101324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxIRMovTnfY7BOPDwAT+IKKznYhpBl0NgKictrAZAM8=;
        b=nluosrmjcTC03EXfQsaf4QF4B6ABR3n/fFgV68xkeVfb1/PZr2WI9P2f2IS3s466lW
         DcLNFtkme7y5gn6bljy+sgz3PdblyG6xGf94d2dwQCE8Kv8AY3jM0typ3V5tTrQbtE6l
         urJ13yKGi4YId+hOvitKw1848zoLduDSWanaFmhA/v1auF2ZYdt7SUXrsLSiqDRINATo
         hm/jZxpAV05TsigbJJlVxcD7wAl6+IskjIE66wt2Trs9goZIJ+zETyuq7Nisjs4VMOlh
         YJj5vsA86fBj01y/cH2FnPMTxDwyrj8ajuNAH8zJ3PJhzfsvgTQ7pA42+5GOrumQt8QO
         DOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769496524; x=1770101324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CxIRMovTnfY7BOPDwAT+IKKznYhpBl0NgKictrAZAM8=;
        b=IpEgX9a46pKArfIqtds0sqs9GqsIRmGy6jPkWG2NGHUziloPrwcYk3cBBTjmMgjSfN
         D9t9h2vCVd8ZBbiPjZjwi50P9Oux85aglIEL8YTbWfUueksYW3czoGIiq1QKnIGavnDg
         7I/LRRzbIzue+an2OOJAFbIt/8MZmsQtEcqTVmwtuxo21f3U/J7UzVCC3naZpdCcrGpN
         aijDFsU9j0Zt+LiDvNWd/+oW2iVRG+WJDaTzMC7igW0jfqpGxVzYGeu74iyTmAhOiGXS
         kUIlfpmxaBHRpGDkRWlkQMgS+HhuZP+2Knbk622Tw9e83UjJQ2D8B/XQkvsaEuyeoW6e
         zJHw==
X-Forwarded-Encrypted: i=1; AJvYcCW6GA1cfjo6SGTLP1SSO9qAoadtAiWddi31sA8VF0l57QRdnPmH+/46nkspNYvtz3/pfHjX4DSju1r3@vger.kernel.org
X-Gm-Message-State: AOJu0YxIzWgarOq9gtVc3U2WtnKX8RvBoFTcbXWH9D0sGc07rV0ca2TS
	t/hUZSSR69LVJsialk9f00mVEAIY82megrultKKuXZo+EFGY3SjEWduB9jkwQ+xyduDkcJdYKdG
	dGWQgEhU4wrNT4dETB5ZcIk1KwnynEvQ=
X-Gm-Gg: AZuq6aIxlxpu8SRl2/NkF3itJ55Pca0BL9eHYZhlfQMVk8dbue0jm19+POaEavRqvN7
	JfNEiDBwcnLW9Lfbyyr743GokEQFuHmJm457ytGRkkQ0BLdLLfgTGTX+QJxv6ras9SPSK2HYP85
	bDnckgVt+gihQLwzTlg2m3VEB2e9b0lxALEQyrMRw2of/J/2zjKYJ5mLNDM2CUFzWPK5Kixtp+M
	d6NguYpL6IeUXnLBNsboRY2OwTGPKsw9/mPCb9jljdwO6XrCAjYQ83OEEpgBjJ5lB7Wgd0=
X-Received: by 2002:a05:6830:2a06:b0:7cf:cbff:85e6 with SMTP id
 46e09a7af769-7d184d86abdmr569911a34.12.1769496524446; Mon, 26 Jan 2026
 22:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260120170749.101e8bcc@kernel.org> <CAHS8izMZxM6rcF+7Lfw=KFv4dmbHGSUrQBPmxO+sYj=V3TRuwQ@mail.gmail.com>
 <aXe2QhzL4DoVbesQ@devvm11784.nha0.facebook.com> <20260126173124.1f0bb98e@kernel.org>
 <aXhUfC7ZyYge1jti@mini-arch>
In-Reply-To: <aXhUfC7ZyYge1jti@mini-arch>
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 26 Jan 2026 22:48:33 -0800
X-Gm-Features: AZwV_QhrHs-Dl6cs5hMxx8ciXfNLSD4IBMm9I6-KLkEEChYQVa1XWumT4YtOBco
Message-ID: <CAKB00G3p9_VUTEW_KQvS1JAd+Ju_pjrU5r-v_p+K8Y=vH__mTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 0/5] net: devmem: improve cpu cost of RX
 token management
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
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

On Mon, Jan 26, 2026 at 10:00=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 01/26, Jakub Kicinski wrote:
> > On Mon, 26 Jan 2026 10:45:22 -0800 Bobby Eshleman wrote:
> > > I'm onboard with improving what we have since it helps all of us
> > > currently using this API, though I'm not opposed to discussing a
> > > redesign in another thread/RFC. I do see the attraction to locating t=
he
> > > core logic in one place and possibly reducing some complexity around
> > > socket/binding relationships.
> > >
> > > FWIW regarding nl, I do see it supports rtnl lock-free operations via
> > > '62256f98f244 rtnetlink: add RTNL_FLAG_DOIT_UNLOCKED' and routing was
> > > recently made lockless with that. I don't see / know of any fast path
> > > precedent. I'm aware there are some things I'm not sure about being
> > > relevant performance-wise, like hitting skb alloc an additional time
> > > every release batch. I'd want to do some minimal latency comparisons
> > > between that path and sockopt before diving head-first.
> >
> > FTR I'm not really pushing Netlink specifically, it may work it
> > may not. Perhaps some other ioctl-y thing exists. Just in general
> > setsockopt() on a specific socket feels increasingly awkward for
> > buffer flow. Maybe y'all disagree.
> >
> > I thought I'd clarify since I may be seen as "Mr Netlink Everywhere" :)
>
> From my side, if we do a completely new uapi, my preference would be on
> an af_xdp like mapped rings (presumably on a netlink socket?) to complete=
ly
> avoid the user-kernel copies.

I second liking that approach. No put_cmsg() and or token alloc overhead (b=
oth
jump up in my profiling).
