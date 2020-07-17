From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 19/22] net/ipv6: factor out MCAST_MSFILTER setsockopt helpers
Date: Fri, 17 Jul 2020 08:23:28 +0200
Message-ID: <20200717062331.691152-20-hch@lst.de>
References: <20200717062331.691152-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200717062331.691152-1-hch-jcswGhMUV9g@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: Alexei Starovoitov <ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Chas Williams <3chas3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pablo Neira Ayuso <pablo-Cap9r6Oaw4JrovVCs/uTlw@public.gmane.org>, Jozsef Kadlecsik <kadlec-Cap9r6Oaw4JrovVCs/uTlw@public.gmane.org>, Florian Westphal <fw-HFFVJYpyMKqzQB+pC5nmwQ@public.gmane.org>, Alexey Kuznetsov <kuznet-v/Mj1YrvjDBInbfyfbPRSQ@public.gmane.org>, Hideaki YOSHIFUJI <yoshfuji-VfPWfsRibaP+Ru+s062T9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bpf-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netfilter-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sctp-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bridge-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dccp-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wpan-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mptcp-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Factor out one helper each for setting the native and compat
version of the MCAST_MSFILTER option.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 net/ipv6/ipv6_sockglue.c | 159 ++++++++++++++++++++-------------------
 1 file changed, 83 insertions(+), 76 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index ef5656f876ac05..6aa49495d7bc0b 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -171,6 +171,87 @@ static int do_ipv6_mcast_group_source(struct sock *sk, int optname,
 	return ip6_mc_source(add, omode, sk, greqs);
 }
 
+static int ipv6_set_mcast_msfilter(struct sock *sk, void __user *optval,
+		int optlen)
+{
+	struct group_filter *gsf;
+	int ret;
+
+	if (optlen < GROUP_FILTER_SIZE(0))
+		return -EINVAL;
+	if (optlen > sysctl_optmem_max)
+		return -ENOBUFS;
+
+	gsf = memdup_user(optval, optlen);
+	if (IS_ERR(gsf))
+		return PTR_ERR(gsf);
+
+	/* numsrc >= (4G-140)/128 overflow in 32 bits */
+	ret = -ENOBUFS;
+	if (gsf->gf_numsrc >= 0x1ffffffU ||
+	    gsf->gf_numsrc > sysctl_mld_max_msf)
+		goto out_free_gsf;
+
+	ret = -EINVAL;
+	if (GROUP_FILTER_SIZE(gsf->gf_numsrc) > optlen)
+		goto out_free_gsf;
+
+	ret = ip6_mc_msfilter(sk, gsf, gsf->gf_slist);
+out_free_gsf:
+	kfree(gsf);
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT
+static int compat_ipv6_set_mcast_msfilter(struct sock *sk, void __user *optval,
+		int optlen)
+{
+	const int size0 = offsetof(struct compat_group_filter, gf_slist);
+	struct compat_group_filter *gf32;
+	void *p;
+	int ret;
+	int n;
+
+	if (optlen < size0)
+		return -EINVAL;
+	if (optlen > sysctl_optmem_max - 4)
+		return -ENOBUFS;
+
+	p = kmalloc(optlen + 4, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	gf32 = p + 4; /* we want ->gf_group and ->gf_slist aligned */
+	ret = -EFAULT;
+	if (copy_from_user(gf32, optval, optlen))
+		goto out_free_p;
+
+	/* numsrc >= (4G-140)/128 overflow in 32 bits */
+	ret = -ENOBUFS;
+	n = gf32->gf_numsrc;
+	if (n >= 0x1ffffffU || n > sysctl_mld_max_msf)
+		goto out_free_p;
+
+	ret = -EINVAL;
+	if (offsetof(struct compat_group_filter, gf_slist[n]) > optlen)
+		goto out_free_p;
+
+	rtnl_lock();
+	lock_sock(sk);
+	ret = ip6_mc_msfilter(sk, &(struct group_filter){
+			.gf_interface = gf32->gf_interface,
+			.gf_group = gf32->gf_group,
+			.gf_fmode = gf32->gf_fmode,
+			.gf_numsrc = gf32->gf_numsrc}, gf32->gf_slist);
+	release_sock(sk);
+	rtnl_unlock();
+
+out_free_p:
+	kfree(p);
+	return ret;
+}
+#endif
+
 static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		    char __user *optval, unsigned int optlen)
 {
@@ -762,37 +843,8 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	}
 	case MCAST_MSFILTER:
-	{
-		struct group_filter *gsf;
-
-		if (optlen < GROUP_FILTER_SIZE(0))
-			goto e_inval;
-		if (optlen > sysctl_optmem_max) {
-			retv = -ENOBUFS;
-			break;
-		}
-		gsf = memdup_user(optval, optlen);
-		if (IS_ERR(gsf)) {
-			retv = PTR_ERR(gsf);
-			break;
-		}
-		/* numsrc >= (4G-140)/128 overflow in 32 bits */
-		if (gsf->gf_numsrc >= 0x1ffffffU ||
-		    gsf->gf_numsrc > sysctl_mld_max_msf) {
-			kfree(gsf);
-			retv = -ENOBUFS;
-			break;
-		}
-		if (GROUP_FILTER_SIZE(gsf->gf_numsrc) > optlen) {
-			kfree(gsf);
-			retv = -EINVAL;
-			break;
-		}
-		retv = ip6_mc_msfilter(sk, gsf, gsf->gf_slist);
-		kfree(gsf);
-
+		retv = ipv6_set_mcast_msfilter(sk, optval, optlen);
 		break;
-	}
 	case IPV6_ROUTER_ALERT:
 		if (optlen < sizeof(int))
 			goto e_inval;
@@ -977,52 +1029,7 @@ int compat_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		return err;
 	}
 	case MCAST_MSFILTER:
-	{
-		const int size0 = offsetof(struct compat_group_filter, gf_slist);
-		struct compat_group_filter *gf32;
-		void *p;
-		int n;
-
-		if (optlen < size0)
-			return -EINVAL;
-		if (optlen > sysctl_optmem_max - 4)
-			return -ENOBUFS;
-
-		p = kmalloc(optlen + 4, GFP_KERNEL);
-		if (!p)
-			return -ENOMEM;
-
-		gf32 = p + 4; /* we want ->gf_group and ->gf_slist aligned */
-		if (copy_from_user(gf32, optval, optlen)) {
-			err = -EFAULT;
-			goto mc_msf_out;
-		}
-
-		n = gf32->gf_numsrc;
-		/* numsrc >= (4G-140)/128 overflow in 32 bits */
-		if (n >= 0x1ffffffU ||
-		    n > sysctl_mld_max_msf) {
-			err = -ENOBUFS;
-			goto mc_msf_out;
-		}
-		if (offsetof(struct compat_group_filter, gf_slist[n]) > optlen) {
-			err = -EINVAL;
-			goto mc_msf_out;
-		}
-
-		rtnl_lock();
-		lock_sock(sk);
-		err = ip6_mc_msfilter(sk, &(struct group_filter){
-				.gf_interface = gf32->gf_interface,
-				.gf_group = gf32->gf_group,
-				.gf_fmode = gf32->gf_fmode,
-				.gf_numsrc = gf32->gf_numsrc}, gf32->gf_slist);
-		release_sock(sk);
-		rtnl_unlock();
-mc_msf_out:
-		kfree(p);
-		return err;
-	}
+		return compat_ipv6_set_mcast_msfilter(sk, optval, optlen);
 	}
 
 	err = do_ipv6_setsockopt(sk, level, optname, optval, optlen);
-- 
2.27.0
