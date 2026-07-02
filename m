Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79D3B992C;
	Thu,  2 Jul 2026 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978354; cv=none; b=uFORAhfMAyBRpd8GYTTKuH6wDyv5Fx7uhW5X+Ks23xenpJEJDRJDG8B9xVUoi0NiU+I7neTiSUyTah31ykkJpbz0YqPe542SonHU5oA7cdadenYicFq5OCl9kCYBRKGpKunez3L1JoARl6b/GFkzJrWBBwo22+d5CRpHWsWNhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978354; c=relaxed/simple;
	bh=28yDBFYY3AWuJOcR19d8dRKyos5zNaHUDVS4ooszIpg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dNRF6zHRo+6Sg5TJIUbXtZmfsbzCIgXIVSrk65n7DLe/eLPY4NkjT6BwZlU4Jys6UL7QGPLFunWYiVmbZYO6ADzjWnmDFX4DhkzOYEBNSYOllLTwyNwdAu61gZsxSVmSBydwlJM2ONVsyMSfvBBxK74mIbMhSfgSLq7FEMCH75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU4Oc7Wc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU4Oc7Wc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E3E1F000E9;
	Thu,  2 Jul 2026 07:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782978351;
	bh=Zpz00LqtbumxgvKsj3x6dXRusjAC6G+eOGQBgk5D4Rs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=DU4Oc7WctIepw8LM1j88KPfRxUA0jW99cwN/kzCgnzHmWu4xcijPCQKmBsfNBtu7U
	 f3VeHVYPCHaDD+Bb8dY/MXXkfCMOvLWMkvqZSaCV0ALSdgwlhCksZq0/NNG7ec6tRj
	 vbOblNu7WKpvzCjdjURhcXUdRef1PfO+jdgWbhPxcQrbt2gej7LTTqxFByGp6lZ1kE
	 brbedfuQ+LZsWXgCl8Djz328OSPYKaCzPYzXTFbe94Vx7MYLFb2y6EUuH1a5hzZYt0
	 8I4oiCqR2pPf5fvF5WoJzuh4BdxuAlQArFxQIyszZH8S8X3P65qGOO7uKGoSXvhNWj
	 aNGs1JQSL7JJw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] vfs: missing inode operation should return a
 consistent error code
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Arnd Bergmann <arnd@arndb.de>, 
 "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>, 
 "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
In-Reply-To: <20260617-asphalt-hochachtung-federn-23e94198aa4a@brauner>
References: <20260531104947.6142-1-jkoolstra@xs4all.nl>
 <c5e32b78aeaa833d18d9b7a566358a6f71d09f23.camel@kernel.org>
 <xdknvjlda7wxwo35toe357nnyaydsllv5g65ogzsomxqgm7jfu@qwtugpoy2rcw>
 <2002074169.107129.1780331273724@kpc.webmail.kpnmail.nl>
 <m5fqzr2ny4zb36u6zhmrrxgl36ycsxvlqnzf5idvsq4lxpfh3i@g276qtqgfv3f>
 <1512332516.1435503.1781209872436@kpc.webmail.kpnmail.nl>
 <20260617-asphalt-hochachtung-federn-23e94198aa4a@brauner>
Date: Thu, 02 Jul 2026 09:45:47 +0200
Message-Id: <20260702-wegdiskutieren-immobilien-klang-261482d68d67@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1466; i=brauner@kernel.org;
 h=from:subject:message-id; bh=28yDBFYY3AWuJOcR19d8dRKyos5zNaHUDVS4ooszIpg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5iete2vU06JfMSadUtY+s4ottV7tGHVsgGOG5ySDtU
 GPTDKeQjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn4eDP8D5tpzCLhvbO2v8l/
 45P1ha/uHzC8rsHCz833IWW5fVb7I6CKQ9K1pav14tpulb70MutVOVcd5i4elikorBUuGdMuxQI A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-06-17 15:24 +0200, Christian Brauner wrote:
> On Thu, Jun 11, 2026 at 10:31:12PM +0200, Jori Koolstra wrote:
> > @Christian, since you suggested equalizing the error codes for missing
> > inode ops, what is your opinion?
> > 
> > > Op 01-06-2026 18:50 CEST schreef Jan Kara <jack@suse.cz>:
> > > 
> > > We certainly can (and sometimes do) modify the returned errors. It is
> > > always just a balancing act between the benefit of the change and chances
> > > somebody will get broken by it. In this case I don't quite see the
> > > benefit, not that I'd be too worried about the a regression but there's
> > > always the chance...
> > > 
> > > 								Honza
> > 
> > No, I get that, and maybe you are right. I feel in this case it would be
> > really odd if this breaks anyone's application. It would mean you are
> > rigorously testing for receiving specific error codes, without handling
> > a general error case. That just seems odd, especially since some of these
> > error codes are not even listed as a possibility for missing ops (like EACCES).
> > I would say we change this and revert if anyone complains. I believe that was
> > also Christian's view in another thread, but I may be mistaken.
> 
> It's a general stance, yes. I think trying to make the things we
> maintain more consistent is worth risking someone reporting a
> regression.

I'm still mulling this patch btw. And I'm leaning more towards trying
this...

