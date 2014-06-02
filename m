From: Chuck Lever <chuck.lever-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 11/32] xfs: convert to struct inode_time
Date: Mon, 2 Jun 2014 15:04:27 -0400
Message-ID: <C57EA6CA-236A-4C93-95F8-21F46A3622DA@oracle.com>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de> <8618458.1EVJCoVbkH@wuerfel> <alpine.LFD.2.11.1406012121430.17310@knanqh.ubzr> <4178301.j9kWdGCRLC@wuerfel> <6868F108-F0B2-423F-AE31-90DF86A5B7DD@oracle.com> <1401735504.6065.227.camel@montana.filmlight.ltd.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401735504.6065.227.camel-a4VQZhDi8cycwdHVwLixqTRg56PAaYer@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Willcocks <roger-nMHR1cC4sak0YOejwGmHqw@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux NFS Mailing List <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, linux-fsdevel <linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, xfs-VZNHf3L845pBDgjK7y7TUQ@public.gmane.org, joseph-qD8j1LwMmJjtCj0u4l0SBw@public.gmane.org
List-Id: linux-arch.vger.kernel.org


On Jun 2, 2014, at 2:58 PM, Roger Willcocks <roger-nMHR1cC4sak0YOejwGmHqw@public.gmane.org> wr=
ote:

>=20
> On Mon, 2014-06-02 at 11:04 -0400, Chuck Lever wrote:
>=20
>> NFSv2/3 timestamps are a pair of unsigned 32-bit values: one value f=
or
>> seconds since midnight GMT Jan 1, 1970, and one value for nanosecond=
s.
>> (See the definition of nfstime3 in RFC 1813).
>>=20
>=20
> nfstime3 could be extended by redefining the otherwise unused
> nanoseconds bits{31,30} as seconds{33,32}, to give a (signed) 34-bit
> seconds field and an unsigned 30-bit nanoseconds field.
>=20
> This could represent 1970 +/- 272 years.
>=20
> Servers could indicate they can understand the extended time format b=
y
> adding a new FSINFO capability - FSF3_CANSETTIME_EX.
>=20
> Clients would use a new SET_TO_CLIENT_TIME_EX time_how enum when send=
ing
> timestamps so old servers would be protected from new clients.

You would have to get the IETF=92s NFSv4 working group to sign off on
this change. Otherwise, Linux would be the only NFSv3 implementation
that supports the extension.

But I suspect the answer you=92d get is =93Use NFSv4.=94

> Old clients don't need to be protected from new servers because the
> on-the-wire bit pattern for dates between 1970 and 2106 stays the sam=
e,
> so they're no worse off than they were before.
>=20
> Arguably the new server ought to clamp out-of-range timestamps before
> sending them to old clients but that would need per-client state (and
> nfs3 is stateless.)

There=92s no reliable way in NFSv3 for clients and servers to identify
the software running on the peer.

Practically speaking, you should assume that the NFSv3 protocol is neve=
r
going to change.

--
Chuck Lever
chuck[dot]lever[at]oracle[dot]com



--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
