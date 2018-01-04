From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 03:10:51 +0000
Message-ID: <1515035438.20588.4.camel@intel.com>
References: <20180103223827.39601-1-mark.rutland@arm.com>
         <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
         <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
         <20180104010754.22ca6a74@alans-desktop>
         <alpine.LRH.2.00.1801040221070.27010@gjva.wvxbf.pm>
         <CAPcyv4ic=X3nMz7deg9NMyvj994+SM9XYoP0u7WvgKaAFSGAYw@mail.gmail.com>
         <CA+55aFx7eJqRA8EWwSCrC+Lr1ZjUvRXSuhrxo+af_Dx3YWKbOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48954 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbeADDLw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Jan 2018 22:11:52 -0500
In-Reply-To: <CA+55aFx7eJqRA8EWwSCrC+Lr1ZjUvRXSuhrxo+af_Dx3YWKbOQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <E6AEC5A81801DA439FF5C73142A1E23A@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "alan@linux.intel.com" <alan@linux.intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Wed, 2018-01-03 at 17:54 -0800, Linus Torvalds wrote:
+AD4- On Wed, Jan 3, 2018 at 5:51 PM, Dan Williams +ADw-dan.j.williams+AEA-intel.co
+AD4- m+AD4- wrote:
+AD4- +AD4- 
+AD4- +AD4- Elena has done the work of auditing static analysis reports to a
+AD4- +AD4- dozen
+AD4- +AD4- or so locations that need some 'nospec' handling.
+AD4- 
+AD4- I'd love to see that patch, just to see how bad things look.
+AD4- 
+AD4- Because I think that really is very relevant to the interface too.
+AD4- 
+AD4- If we're talking +ACI-a dozen locations+ACI- that are fairly well
+AD4- constrained,
+AD4- that's very different from having thousands all over the place.
+AD4- 

Note, the following is Elena's work, I'm just helping poke the upstream
discussion along while she's offline.

Elena audited the static analysis reports down to the following
locations where userspace provides a value for a conditional branch and
then later creates a dependent load on that same userspace controlled
value.

'osb()', observable memory barrier, resolves to an lfence on x86. My
concern with these changes is that it is not clear what content within
the branch block is of concern. Peter's 'if+AF8-nospec' proposal combined
with Mark's 'nospec+AF8-load' would seem to clear that up, from a self
documenting code perspective, and let archs optionally protect entire
conditional blocks or individual loads within those blocks.

Note that these are +ACI-a human looked at static analysis reports and
could not rationalize that these are false positives+ACI-. Specific domain
knowledge about these paths may find that some of them are indeed false
positives.

The change to m+AF8-start in kernel/user+AF8-namespace.c is interesting because
that's an example where the nospec+AF8-load() approach by itself would need
to barrier speculation twice whereas if+AF8-nospec can do it once for the
whole block.

+AFs- forgive any whitespace damage +AF0-

8+ADw----
diff --git a/drivers/media/usb/uvc/uvc+AF8-v4l2.c b/drivers/media/usb/uvc/uvc+AF8-v4l2.c
index 3e7e283a44a8..65175bbe805f 100644
--- a/drivers/media/usb/uvc/uvc+AF8-v4l2.c
+-+-+- b/drivers/media/usb/uvc/uvc+AF8-v4l2.c
+AEAAQA- -821,6 +-821,7 +AEAAQA- static int uvc+AF8-ioctl+AF8-enum+AF8-input(struct file +ACo-file, void +ACo-fh,
 		+AH0-
 		pin +AD0- iterm-+AD4-id+ADs-
 	+AH0- else if (index +ADw- selector-+AD4-bNrInPins) +AHs-
+-		osb()+ADs-
 		pin +AD0- selector-+AD4-baSourceID+AFs-index+AF0AOw-
 		list+AF8-for+AF8-each+AF8-entry(iterm, +ACY-chain-+AD4-entities, chain) +AHs-
 			if (+ACE-UVC+AF8-ENTITY+AF8-IS+AF8-ITERM(iterm))
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 988c8857d78c..cf267b709af6 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+-+-+- b/drivers/net/wireless/ath/carl9170/main.c
+AEAAQA- -1388,6 +-1388,7 +AEAAQA- static int carl9170+AF8-op+AF8-conf+AF8-tx(struct ieee80211+AF8-hw +ACo-hw,
 
 	mutex+AF8-lock(+ACY-ar-+AD4-mutex)+ADs-
 	if (queue +ADw- ar-+AD4-hw-+AD4-queues) +AHs-
+-		osb()+ADs-
 		memcpy(+ACY-ar-+AD4-edcf+AFs-ar9170+AF8-qmap+AFs-queue+AF0AXQ-, param, sizeof(+ACo-param))+ADs-
 		ret +AD0- carl9170+AF8-set+AF8-qos(ar)+ADs-
 	+AH0- else +AHs-
diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
index ab6d39e12069..f024f1ad81ff 100644
--- a/drivers/net/wireless/intersil/p54/main.c
+-+-+- b/drivers/net/wireless/intersil/p54/main.c
+AEAAQA- -415,6 +-415,7 +AEAAQA- static int p54+AF8-conf+AF8-tx(struct ieee80211+AF8-hw +ACo-dev,
 
 	mutex+AF8-lock(+ACY-priv-+AD4-conf+AF8-mutex)+ADs-
 	if (queue +ADw- dev-+AD4-queues) +AHs-
+-		osb()+ADs-
 		P54+AF8-SET+AF8-QUEUE(priv-+AD4-qos+AF8-params+AFs-queue+AF0-, params-+AD4-aifs,
 			params-+AD4-cw+AF8-min, params-+AD4-cw+AF8-max, params-+AD4-txop)+ADs-
 		ret +AD0- p54+AF8-set+AF8-edcf(priv)+ADs-
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index 38678e9a0562..b4a2a7ba04e8 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+-+-+- b/drivers/net/wireless/st/cw1200/sta.c
+AEAAQA- -619,6 +-619,7 +AEAAQA- int cw1200+AF8-conf+AF8-tx(struct ieee80211+AF8-hw +ACo-dev, struct ieee80211+AF8-vif +ACo-vif,
 	mutex+AF8-lock(+ACY-priv-+AD4-conf+AF8-mutex)+ADs-
 
 	if (queue +ADw- dev-+AD4-queues) +AHs-
+-		osb()+ADs-
 		old+AF8-uapsd+AF8-flags +AD0- le16+AF8-to+AF8-cpu(priv-+AD4-uapsd+AF8-info.uapsd+AF8-flags)+ADs-
 
 		WSM+AF8-TX+AF8-QUEUE+AF8-SET(+ACY-priv-+AD4-tx+AF8-queue+AF8-params, queue, 0, 0, 0)+ADs-
diff --git a/drivers/scsi/qla2xxx/qla+AF8-mr.c b/drivers/scsi/qla2xxx/qla+AF8-mr.c
index d5da3981cefe..dec8b6e087e3 100644
--- a/drivers/scsi/qla2xxx/qla+AF8-mr.c
+-+-+- b/drivers/scsi/qla2xxx/qla+AF8-mr.c
+AEAAQA- -2304,10 +-2304,12 +AEAAQA- qlafx00+AF8-status+AF8-entry(scsi+AF8-qla+AF8-host+AF8-t +ACo-vha, struct rsp+AF8-que +ACo-rsp, void +ACo-pkt)
 	req +AD0- ha-+AD4-req+AF8-q+AF8-map+AFs-que+AF0AOw-
 
 	/+ACo- Validate handle. +ACo-/
-	if (handle +ADw- req-+AD4-num+AF8-outstanding+AF8-cmds)
+-	if (handle +ADw- req-+AD4-num+AF8-outstanding+AF8-cmds) +AHs-
+-		osb()+ADs-
 		sp +AD0- req-+AD4-outstanding+AF8-cmds+AFs-handle+AF0AOw-
-	else
+-	+AH0- else +AHs-
 		sp +AD0- NULL+ADs-
+-	+AH0-
 
 	if (sp +AD0APQ- NULL) +AHs-
 		ql+AF8-dbg(ql+AF8-dbg+AF8-io, vha, 0x3034,
+AEAAQA- -2655,10 +-2657,12 +AEAAQA- qlafx00+AF8-multistatus+AF8-entry(struct scsi+AF8-qla+AF8-host +ACo-vha,
 		req +AD0- ha-+AD4-req+AF8-q+AF8-map+AFs-que+AF0AOw-
 
 		/+ACo- Validate handle. +ACo-/
-		if (handle +ADw- req-+AD4-num+AF8-outstanding+AF8-cmds)
+-		if (handle +ADw- req-+AD4-num+AF8-outstanding+AF8-cmds) +AHs-
+-			osb()+ADs-
 			sp +AD0- req-+AD4-outstanding+AF8-cmds+AFs-handle+AF0AOw-
-		else
+-		+AH0- else +AHs-
 			sp +AD0- NULL+ADs-
+-		+AH0-
 
 		if (sp +AD0APQ- NULL) +AHs-
 			ql+AF8-dbg(ql+AF8-dbg+AF8-io, vha, 0x3044,
diff --git a/drivers/thermal/int340x+AF8-thermal/int340x+AF8-thermal+AF8-zone.c b/drivers/thermal/int340x+AF8-thermal/int340x+AF8-thermal+AF8-zone.c
index 145a5c53ff5c..d732b34e120d 100644
--- a/drivers/thermal/int340x+AF8-thermal/int340x+AF8-thermal+AF8-zone.c
+-+-+- b/drivers/thermal/int340x+AF8-thermal/int340x+AF8-thermal+AF8-zone.c
+AEAAQA- -57,15 +-57,16 +AEAAQA- static int int340x+AF8-thermal+AF8-get+AF8-trip+AF8-temp(struct thermal+AF8-zone+AF8-device +ACo-zone,
 	if (d-+AD4-override+AF8-ops +ACYAJg- d-+AD4-override+AF8-ops-+AD4-get+AF8-trip+AF8-temp)
 		return d-+AD4-override+AF8-ops-+AD4-get+AF8-trip+AF8-temp(zone, trip, temp)+ADs-
 
-	if (trip +ADw- d-+AD4-aux+AF8-trip+AF8-nr)
+-	if (trip +ADw- d-+AD4-aux+AF8-trip+AF8-nr) +AHs-
+-		osb()+ADs-
 		+ACo-temp +AD0- d-+AD4-aux+AF8-trips+AFs-trip+AF0AOw-
-	else if (trip +AD0APQ- d-+AD4-crt+AF8-trip+AF8-id)
+-	+AH0- else if (trip +AD0APQ- d-+AD4-crt+AF8-trip+AF8-id) +AHs-
 		+ACo-temp +AD0- d-+AD4-crt+AF8-temp+ADs-
-	else if (trip +AD0APQ- d-+AD4-psv+AF8-trip+AF8-id)
+-	+AH0- else if (trip +AD0APQ- d-+AD4-psv+AF8-trip+AF8-id) +AHs-
 		+ACo-temp +AD0- d-+AD4-psv+AF8-temp+ADs-
-	else if (trip +AD0APQ- d-+AD4-hot+AF8-trip+AF8-id)
+-	+AH0- else if (trip +AD0APQ- d-+AD4-hot+AF8-trip+AF8-id) +AHs-
 		+ACo-temp +AD0- d-+AD4-hot+AF8-temp+ADs-
-	else +AHs-
+-	+AH0- else +AHs-
 		for (i +AD0- 0+ADs- i +ADw- INT340X+AF8-THERMAL+AF8-MAX+AF8-ACT+AF8-TRIP+AF8-COUNT+ADs- i+-+-) +AHs-
 			if (d-+AD4-act+AF8-trips+AFs-i+AF0-.valid +ACYAJg-
 			    d-+AD4-act+AF8-trips+AFs-i+AF0-.id +AD0APQ- trip) +AHs-
diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index 401e64cde1be..c5394760d26b 100644
--- a/fs/udf/misc.c
+-+-+- b/fs/udf/misc.c
+AEAAQA- -104,6 +-104,8 +AEAAQA- struct genericFormat +ACo-udf+AF8-add+AF8-extendedattr(struct inode +ACo-inode, uint32+AF8-t size,
 					iinfo-+AD4-i+AF8-lenEAttr) +AHs-
 				uint32+AF8-t aal +AD0-
 					le32+AF8-to+AF8-cpu(eahd-+AD4-appAttrLocation)+ADs-
+-
+-				osb()+ADs-
 				memmove(+ACY-ea+AFs-offset - aal +- size+AF0-,
 					+ACY-ea+AFs-aal+AF0-, offset - aal)+ADs-
 				offset -+AD0- aal+ADs-
+AEAAQA- -114,6 +-116,8 +AEAAQA- struct genericFormat +ACo-udf+AF8-add+AF8-extendedattr(struct inode +ACo-inode, uint32+AF8-t size,
 					iinfo-+AD4-i+AF8-lenEAttr) +AHs-
 				uint32+AF8-t ial +AD0-
 					le32+AF8-to+AF8-cpu(eahd-+AD4-impAttrLocation)+ADs-
+-
+-				osb()+ADs-
 				memmove(+ACY-ea+AFs-offset - ial +- size+AF0-,
 					+ACY-ea+AFs-ial+AF0-, offset - ial)+ADs-
 				offset -+AD0- ial+ADs-
+AEAAQA- -125,6 +-129,8 +AEAAQA- struct genericFormat +ACo-udf+AF8-add+AF8-extendedattr(struct inode +ACo-inode, uint32+AF8-t size,
 					iinfo-+AD4-i+AF8-lenEAttr) +AHs-
 				uint32+AF8-t aal +AD0-
 					le32+AF8-to+AF8-cpu(eahd-+AD4-appAttrLocation)+ADs-
+-
+-				osb()+ADs-
 				memmove(+ACY-ea+AFs-offset - aal +- size+AF0-,
 					+ACY-ea+AFs-aal+AF0-, offset - aal)+ADs-
 				offset -+AD0- aal+ADs-
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 1c65817673db..dbc12007da51 100644
--- a/include/linux/fdtable.h
+-+-+- b/include/linux/fdtable.h
+AEAAQA- -82,8 +-82,10 +AEAAQA- static inline struct file +ACoAXwBf-fcheck+AF8-files(struct files+AF8-struct +ACo-files, unsigned i
 +AHs-
 	struct fdtable +ACo-fdt +AD0- rcu+AF8-dereference+AF8-raw(files-+AD4-fdt)+ADs-
 
-	if (fd +ADw- fdt-+AD4-max+AF8-fds)
+-	if (fd +ADw- fdt-+AD4-max+AF8-fds) +AHs-
+-		osb()+ADs-
 		return rcu+AF8-dereference+AF8-raw(fdt-+AD4-fd+AFs-fd+AF0-)+ADs-
+-	+AH0-
 	return NULL+ADs-
 +AH0-
 
diff --git a/kernel/user+AF8-namespace.c b/kernel/user+AF8-namespace.c
index 246d4d4ce5c7..aa0be8cef2d4 100644
--- a/kernel/user+AF8-namespace.c
+-+-+- b/kernel/user+AF8-namespace.c
+AEAAQA- -648,15 +-648,18 +AEAAQA- static void +ACo-m+AF8-start(struct seq+AF8-file +ACo-seq, loff+AF8-t +ACo-ppos,
 +AHs-
 	loff+AF8-t pos +AD0- +ACo-ppos+ADs-
 	unsigned extents +AD0- map-+AD4-nr+AF8-extents+ADs-
-	smp+AF8-rmb()+ADs-
 
-	if (pos +AD4APQ- extents)
-		return NULL+ADs-
+-	/+ACo- paired with smp+AF8-wmb in map+AF8-write +ACo-/
+-	smp+AF8-rmb()+ADs-
 
-	if (extents +ADwAPQ- UID+AF8-GID+AF8-MAP+AF8-MAX+AF8-BASE+AF8-EXTENTS)
-		return +ACY-map-+AD4-extent+AFs-pos+AF0AOw-
+-	if (pos +ADw- extents) +AHs-
+-		osb()+ADs-
+-		if (extents +ADwAPQ- UID+AF8-GID+AF8-MAP+AF8-MAX+AF8-BASE+AF8-EXTENTS)
+-			return +ACY-map-+AD4-extent+AFs-pos+AF0AOw-
+-		return +ACY-map-+AD4-forward+AFs-pos+AF0AOw-
+-	+AH0-
 
-	return +ACY-map-+AD4-forward+AFs-pos+AF0AOw-
+-	return NULL+ADs-
 +AH0-
 
 static void +ACo-uid+AF8-m+AF8-start(struct seq+AF8-file +ACo-seq, loff+AF8-t +ACo-ppos)
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 125c1eab3eaa..56909c8fa025 100644
--- a/net/ipv4/raw.c
+-+-+- b/net/ipv4/raw.c
+AEAAQA- -476,6 +-476,7 +AEAAQA- static int raw+AF8-getfrag(void +ACo-from, char +ACo-to, int offset, int len, int odd,
 	if (offset +ADw- rfv-+AD4-hlen) +AHs-
 		int copy +AD0- min(rfv-+AD4-hlen - offset, len)+ADs-
 
+-		osb()+ADs-
 		if (skb-+AD4-ip+AF8-summed +AD0APQ- CHECKSUM+AF8-PARTIAL)
 			memcpy(to, rfv-+AD4-hdr.c +- offset, copy)+ADs-
 		else
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 761a473a07c5..0942784f3f8d 100644
--- a/net/ipv6/raw.c
+-+-+- b/net/ipv6/raw.c
+AEAAQA- -729,6 +-729,7 +AEAAQA- static int raw6+AF8-getfrag(void +ACo-from, char +ACo-to, int offset, int len, int odd,
 	if (offset +ADw- rfv-+AD4-hlen) +AHs-
 		int copy +AD0- min(rfv-+AD4-hlen - offset, len)+ADs-
 
+-		osb()+ADs-
 		if (skb-+AD4-ip+AF8-summed +AD0APQ- CHECKSUM+AF8-PARTIAL)
 			memcpy(to, rfv-+AD4-c +- offset, copy)+ADs-
 		else
diff --git a/net/mpls/af+AF8-mpls.c b/net/mpls/af+AF8-mpls.c
index 8ca9915befc8..7f83abdea255 100644
--- a/net/mpls/af+AF8-mpls.c
+-+-+- b/net/mpls/af+AF8-mpls.c
+AEAAQA- -81,6 +-81,8 +AEAAQA- static struct mpls+AF8-route +ACo-mpls+AF8-route+AF8-input+AF8-rcu(struct net +ACo-net, unsigned index)
 	if (index +ADw- net-+AD4-mpls.platform+AF8-labels) +AHs-
 		struct mpls+AF8-route +AF8AXw-rcu +ACoAKg-platform+AF8-label +AD0-
 			rcu+AF8-dereference(net-+AD4-mpls.platform+AF8-label)+ADs-
+-
+-		osb()+ADs-
 		rt +AD0- rcu+AF8-dereference(platform+AF8-label+AFs-index+AF0-)+ADs-
 	+AH0-
 	return rt+ADs-
